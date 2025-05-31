
// Defines a generic formated entry on the cv as a
// block to the left containing the date and a block
// to the right containing the informations about the
// entry.
#let generic_entry_formatter(date, main_topic, organization, extra_info, extra_link: "", code_link: "", lang: "pt") = {


  let more_info_phrase = ""
  let get_code_phrase = ""

  if lang == "pt" {
    more_info_phrase = "(mais informações)"
    get_code_phrase = "(repositório com código)"

  } else if lang == "en" {
    more_info_phrase = "(more info)"
    get_code_phrase = "(code repo)"
  }


  let learn_more = ""
  if extra_link != "" {
    learn_more = link(extra_link, more_info_phrase)
  }

  if code_link != "" {
    learn_more += link(code_link, get_code_phrase)
  }

  block(breakable: false,
  grid(
    columns: (0.10fr, 0.9fr),
    align: (right, left),
    column-gutter: 1em,
    smallcaps(date),
    grid.vline(stroke: 0.5pt, x: 1),
    block(inset: (left: 10pt),
      [#main_topic \ #text(size: 10pt)[#organization] \ #text(size: 9pt)[#extra_info #learn_more]]
    )
  )
  )
  v(1em)
}

// Defines a bib formated entry on the cv as a
// block to the left containing the date and a block
// to the right containing the informations about the
// entry.
#let bib_entry_formatter(date, bibcode, extra_info, extra_link: "", code_link: "") = {

  let learn_more = ""

  if extra_link != "" {
    learn_more = link(extra_link, "(mais informações)")
  }

  if code_link != "" {
    learn_more += link(code_link, "(repositório com código)")
  }

  block(breakable: false,
  grid(
    columns: (0.10fr, 0.9fr),
    align: (right, left),
    column-gutter: 1em,
    smallcaps(date),
    grid.vline(stroke: 0.5pt, x: 1),
    block(inset: (left: 10pt),
      [#cite(label(bibcode), form: "full") \ #text(size: 9pt)[#extra_info #learn_more]]
    )
  )
  )
  v(1em)
}

// Given path to CSV containing generic entries
// it prints its entries using the entry function
#let print_csv_generic_entries(path, entry_formatter, lang: "pt") = [

  #let exp = csv(path, row-type : dictionary).sorted(key: it=> int(it.id)).rev()

  #for record in exp {
    entry_formatter(
      [#record.start_date \ #record.end_date],
      eval(record.main_topic, mode: "markup"),
      record.organization,
      eval(record.extra_info, mode: "markup"),
      extra_link: record.info_link,
      code_link: record.code_link,
      lang: lang,
    )
  }
]

// Given path to CSV containing bib entries
// it prints its entries using the entry function
#let print_csv_bib_entries(path, entry_formatter) = [

  #let exp = csv(path, row-type : dictionary).sorted(key: it=> int(it.id)).rev()

  #for record in exp {
    entry_formatter(
      [#record.date],
      record.bibcode,
      eval(record.extra_info, mode: "markup"),
      extra_link: record.info_link,
      code_link: record.code_link
    )
  }
]

#let print_skills_list(path) = [

  #let tools = csv(path, row-type: dictionary)
  #let cat =  ()

  #for line in tools {
    cat.push(line.tool_type)
  }

  #let cat = cat.dedup()

  #let contents = ()

  #for t in cat {
    contents.push(smallcaps(t) + ":")
    let itens  = tools.filter(it => it.tool_type == t)
    contents.push[#itens.fold([], (acc, it,) => acc + [#it.tool_name (#it.proficiency_level) \ ])]

  }


  #grid(
    columns: 2,
    row-gutter: 2em,
    column-gutter: 1em,
    align: (right, left),
    ..contents
  )
]
