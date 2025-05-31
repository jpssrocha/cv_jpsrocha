#import "@preview/hidden-bib:0.1.0": hidden-bibliography
#import "./cv_functions.typ": (generic_entry_formatter,
                                bib_entry_formatter,
                                print_csv_generic_entries,
                                print_csv_bib_entries,
                                print_skills_list
                              )


#set text(font: "New Computer Modern")
#show link: set text(fill: blue)


#hidden-bibliography(
  bibliography("scientific_papers.bib")
)

#show heading: it => {
  show: smallcaps
  v(0.5em)
  set block(spacing: 0.35em)
  set text(size: 17pt, weight: "regular")
  it
  line(length: 100%)
  v(0.5em)
} 


#let lang = "en"
#let name = "João Pedro Rocha"
#let location = "Petrópolis, Rio de Janeiro, Brasil"
#let email = "joaopedro0498@hotmail.com"
#let gh = link("https://github.com/jpssrocha")[jpssrocha]
#let cel = "(73) 9 9939-3019"
#let li = link("https://www.linkedin.com/in/joao-pedro-rocha-b28b7b219/")[João Pedro Rocha]
#let oid = link("https://orcid.org/0000-0001-7561-5067")[0000-0001-7561-5067]
#let site = link("jprocha.me")


#align(center)[ #smallcaps(text(name, size: 24pt)) ]

#v(0.5cm)

= Basic Info

#grid(
  columns: 2,
  row-gutter: 0.5em,
  column-gutter: 1em,
  align: (right, left),
  smallcaps[Location:]     , location,
  smallcaps[Email:]           , email,
  smallcaps[GitHub:]          , gh,
  smallcaps[Phone/Whatsapp:], cel,
  smallcaps[LinkedIn:]        , li,
  smallcaps[ORCID:]           , oid,
  smallcaps[Site:]            , site,
  smallcaps[Languages:]         , [English (Advanced)\ Spanish (Intermediary)\ Portuguese (Native) ]
)

= Academic Background

#generic_entry_formatter(
  [2024 \ Today],
  [Masters candidate in #smallcaps[Computational Modeling]],
  [*National Laboratory of Scientific Computing* (LNCC)],
  [Petrópolis, Rio de Janeiro, Brazil]
)

#generic_entry_formatter(
  [2017 \ 2023],
  [Bachelor's degree in #smallcaps[Physics]],
  [Universidade Estadual de Santa Cruz (UESC)],
  [Ilhéus, Bahia, Brasil]
)
= Professional Experience

#print_csv_generic_entries(
  "cv_data_en/professional_xp.csv",
  generic_entry_formatter,
  lang: "en"
)

= Scientific Articles

#print_csv_bib_entries(
  "cv_data_en/papers.csv",
  bib_entry_formatter
)

= Research and outreach projects

#print_csv_generic_entries(
  "cv_data_en/research_extension_projects.csv",
  generic_entry_formatter,
  lang: "en"
)

= Courses Given
#print_csv_generic_entries(
  "cv_data_en/courses.csv",
  generic_entry_formatter,
  lang: "en"
)


= Extracurricular Activities

#print_csv_generic_entries(
  "cv_data_en/extra_curricular_activity.csv",
  generic_entry_formatter,
  lang: "en"
)

= Event Organization

#print_csv_generic_entries(
  "cv_data_en/event_organization.csv",
  generic_entry_formatter,
  lang: "en"
)

= Events Attended

#print_csv_generic_entries(
  "cv_data_en/event_participation.csv",
  generic_entry_formatter,
  lang: "en"
)

= Additional Formal Training

#print_csv_generic_entries(
  "cv_data_en/additional_formal_training.csv",
  generic_entry_formatter,
  lang: "en"
)

= Software Tools

#print_skills_list("cv_data_en/software.csv")
