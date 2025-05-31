import os
from pathlib import Path
import logging
from functools import partial

from dotenv import load_dotenv
import pandas as pd
import deepl



def translate_by_dict(text: str, translation_dict: dict[str, str]) -> str:
    """
    Given a text and a dictionary of translations, returns the text with the
    dictionary replacements.
    """
    for key in translation_dict:
        text = text.replace(key, translation_dict[key])
    return text



def fits_deepl_quota(character_count: int) -> bool:
    """Given a character count, checks if is inside the deepl quota"""

    global TRANSLATOR

    logger.info("Checking deepl usage quota")

    counter = TRANSLATOR.get_usage().character

    if counter and counter.limit and counter.count:
        available_quota = counter.limit - counter.count
    else:
        raise RuntimeError("Could not recover counter limits from API")

    if available_quota > character_count:
        return True

    return False


def make_translation(text: str, source_lang="PT", target_lang="EN-US") -> str:
    """Given string send to deepl for translation and return resulting string"""

    global TRANSLATOR

    if text == "":
        logger.info("String was empty returning imediatly")
        return ""

    return TRANSLATOR.translate_text(text, source_lang=source_lang, target_lang=target_lang).text
    


def main(default_language = "pt", target_language = "en"):
    """
    From the path of the default language folder containing the csv's with
    the entries get default files (that are edited by hand) and add translated
    entries to the target language files, keeping the entries that were already
    there untouched in case the translated version were edited by hand.

    Parameters
    ----------

        DEFAULT_LANGUAGE: str
        TARGET_LANGUAGE: str

    Returns
    -------

        None

    Side Effects
    ------------

        Write the updated csv files in the target language folder.
        
    """

    print("Starting translation script.")

    quota_info_start = TRANSLATOR.get_usage().character.count

    if not quota_info_start is None:
        print(f"Deepl quota in {quota_info_start/500_000}%")

    default_files: list[Path] = sorted(list(Path(FOLDER_BASE + DEFAULT_LANGUAGE).glob("*csv")))

    # from default file path construct target path

    target_folder: str = FOLDER_BASE + TARGET_LANGUAGE
    target_files = [Path(target_folder) / f.name for f in default_files]


    for target_file, default_file in zip(target_files, default_files):

        logger.debug(f"Processing file: {default_file}")


        if target_file.name in SKIP_LIST:
            logger.info(f"Skipping file: {target_file}, because it is on the skip list")
            continue

        # load default file into dataframe with index = id column
        default_df: pd.DataFrame = pd.read_csv(default_file, index_col="id", keep_default_na=False)

        # check if target path exists
        ## if not build empty dataframe
 
        if target_file.is_file():
            target_df: pd.DataFrame = pd.read_csv(target_file, index_col="id", keep_default_na=False)
        else:
            logger.info(f"Translation file not created. Initializing target dataframe for {target_file}")
            target_df: pd.DataFrame = pd.DataFrame(columns=default_df.columns)
        
        # select indices missing on the target dataframe that are present on the default one
        ## if none abort

        missing_idx = default_df.index.difference(target_df.index)
        difference_df = default_df.loc[missing_idx]

        if len(difference_df) == 0:
            logger.info(f"Skipping file. No new entries detected for {target_file}")
            continue


        # send the relevant lines for api to translate via map
        ## Calculate the total of characters and check is possible to send

        total_chars = 0

        for key in TRANSLATE_LIST:
            if key in difference_df.columns:
                total_chars += difference_df.loc[:, key].map(len).sum()        

        print(total_chars)

        if not fits_deepl_quota(total_chars):
            logger.warning(f"Aborting operation. Can't fit the {total_chars} character required for file: {target_file} into Deepl quota ")
            continue


        for key in TRANSLATE_LIST:
            if key in difference_df.columns:
                difference_df[key] = difference_df[key].map(make_translation).str.replace("\n", "")

        if "end_date" in difference_df.columns:
            fmt = partial(translate_by_dict, translation_dict={"Hoje": "Today"})
            difference_df.end_date = difference_df.end_date.apply(fmt)

        # Write the updated dataframe to the correct folder
        new_df = pd.concat([target_df, difference_df])

        logger.info(f"Writing updated dataframe for {target_file}")
        new_df.to_csv(target_file, index_label="id")



    # Check final state of the quota
    quota_info_end = TRANSLATOR.get_usage().character

    if quota_info_start and quota_info_end.count and quota_info_end.limit:
        delta = (quota_info_end.count - quota_info_start)/quota_info_end.limit
        print(f"This run used: {delta*100}% of the quota")


if __name__ == "__main__":

    # Setting up global program state

    logging.basicConfig(filename="translation.log", level=logging.DEBUG)
    logger = logging.getLogger()

    FOLDER_BASE: str = "./cv_data_"
    DEFAULT_LANGUAGE: str = "pt"
    TARGET_LANGUAGE: str = "en"

    load_dotenv()
    API_KEY = os.getenv("DEEPL_API_KEY")

    if API_KEY is None:
        raise RuntimeError("DEEPL translator API is not setup as environment variable. Aborting program execution.")

    TRANSLATOR = deepl.Translator(API_KEY)

    TRANSLATE_LIST: list[str] = ["main_topic", "extra_info"] + ["tool_type", "proficiency_level"]
    SKIP_LIST = [] # ["software.csv"]

    main()
