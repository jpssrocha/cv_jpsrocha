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


#let lang = "pt-br"
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

= Informações Básicas

#grid(
  columns: 2,
  row-gutter: 0.5em,
  column-gutter: 1em,
  align: (right, left),
  smallcaps[Localização:]     , location,
  smallcaps[Email:]           , email,
  smallcaps[GitHub:]          , gh,
  smallcaps[Celular/Whatsapp:], cel,
  smallcaps[LinkedIn:]        , li,
  smallcaps[ORCID:]           , oid,
  smallcaps[Site:]            , site,
  smallcaps[Linguas:]         , [Inglês (Avançado)\ Espanhol (Intermediário)\ Português (Nativo) ]
)

= Formação Acadêmica

#generic_entry_formatter(
  [2024 \ Hoje],
  [Mestrando em #smallcaps[Modelagem Computacional]],
  [*Laboratório Nacional de Computação Científica* (LNCC)],
  [Petrópolis, Rio de Janeiro, Brasil]
)

#generic_entry_formatter(
  [2017 \ 2023],
  [Bacharelado em #smallcaps[Física]],
  [Universidade Estadual de Santa Cruz (UESC)],
  [Ilhéus, Bahia, Brasil]
)
= Experiência Profissional

#print_csv_generic_entries(
  "cv_data_pt/professional_xp.csv",
  generic_entry_formatter
)

= Artigos Científicos

#print_csv_bib_entries(
  "cv_data_pt/papers.csv",
  bib_entry_formatter
)

= Projetos de Pesquisa e Extensão

#print_csv_generic_entries(
 "cv_data_pt/research_extension_projects.csv",
 generic_entry_formatter
)

= Cursos Ministrados

#print_csv_generic_entries(
 "cv_data_pt/courses.csv",
 generic_entry_formatter
)


= Atividades Extracurriculares

#print_csv_generic_entries(
 "cv_data_pt/extra_curricular_activity.csv",
 generic_entry_formatter
)

= Organização de Eventos

#print_csv_generic_entries(
 "cv_data_pt/event_organization.csv",
 generic_entry_formatter
)

= Participação em Eventos

#print_csv_generic_entries(
 "cv_data_pt/event_participation.csv",
 generic_entry_formatter
)

= Formação Complementar

#print_csv_generic_entries(
 "cv_data_pt/additional_formal_training.csv",
 generic_entry_formatter
)

= Ferramentas de Software

#print_skills_list("cv_data_pt/software.csv")
