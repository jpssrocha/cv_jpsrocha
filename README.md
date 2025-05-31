# CV Automation's

This repository contains some CV automation's i've created after losing the
chance to apply for an opportunity for not having the time to update my CV.
I've used the scripting capabilities of the Typst typesetting system to
create some templates that get my entries from a set of spreadsheets that 
i edit manually and add it to the document in formatted entries, as well as
a translation script, and a Makefile to automate the build. 

The end result is that can keep track of my stuff in a simple set of csv
spreadsheets that are in my mother language that are practical to edit and then
run `make` that it will:

- Check for changes
- Regenerate the PDF document in Portuguese from the updated spreadsheet
- Translate new entries to English
- Regenerate the PDF document in English

And with that i can check the results and modify what i see fit then run `make upload`
to then push changes to git with the pdf documents being tracked by "git-lfs" that will
then put it in a location that is already linked to my site!

# How it works

Under the hood this document is using Typst for loading data, templating and
generating documents documents, and the Deepl API for translations over a
python script.

It needs a deepl api key stored in a `.env` file to be loaded as a
`DEEPL_API_KEY` environment variable.
