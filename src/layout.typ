#import "constantes.typ": *
#import "elementos.typ": *

#let abnt_udc(
  titulo,
  aluno,
  curso,
  orientador,
  natureza,
  local,
  data,
  body,
) = [
  #set page(
    paper: "a4",
    margin: MARGENS,
    // A numeração só é mostrada após o sumário.
    header: context {
      let fim_sumario = query(<fim_sumario>)
      if fim_sumario.len() > 0 {
        let fim_pag = fim_sumario.first().location().page()
        if here().page() >= fim_pag {
          set align(right)
          set text(size: TAMANHOS_FONTE.minusculo)
          counter(page).display("1")
        }
      }
    },
  )

  #set text(
    lang: "pt",
    font: FONTES.corpo,
    size: TAMANHOS_FONTE.corpo,
    ligatures: true,
    discretionary-ligatures: true,
  )

  #set heading(
    numbering: "1.1  ",
  )

  #show heading: it => [
    #set text(size: TAMANHOS_FONTE.corpo)

    #if it.level == 1 [
      #set text(weight: "bold")
      #set block(below: 4.75em, above: 2.25em)
      #block(upper(it))
    ] else if it.level == 2 [
      #set text(weight: "regular")
      #set block(below: 1.75em, above: 2.25em)
      #block(upper(it))
    ] else if it.level == 3 [
      #set text(weight: "bold")
      #set block(below: 1.75em, above: 2.25em)
      #block(it)
    ] else [
      #set text(weight: "regular", style: "italic")
      #set block(below: 1.75em, above: 2.25em)
      #block(it)
    ]
  ]

  #set par(
    justify: true,
    // Justificação melhorada com base em: https://typst.app/docs/reference/model/par/#parameters-justification-limits.
    justification-limits: (
      tracking: (min: -0.01em, max: 0.02em),
    ),
    first-line-indent: (amount: 1.5cm, all: true),
    leading: 0.8em,
    spacing: 0.8em,
  )

  // Título de outline.
  #show outline: it => [
    #show heading: set heading(outlined: false)
    #show heading: set align(center)

    #show heading: it => [
      #it
      #v(4em)
    ]

    #it

    #pagebreak()
  ]

  // Lista de itens.
  #let entry_de_figura(entry) = link(
    entry.element.location(),
    entry.indented([#entry.prefix()#h(0.5em)–], entry.inner()),
  )

  #show outline.where(target: selector(figure.where(kind: image))): it => {
    show outline.entry: it => entry_de_figura(it)
    it
  }

  #show outline.where(target: selector(figure.where(kind: table))): it => {
    show outline.entry: it => entry_de_figura(it)
    it
  }

  #show outline.where(target: selector(figure.where(kind: raw))): it => {
    show outline.entry: it => entry_de_figura(it)
    it
  }

  // Sumário.

  #set outline(indent: 0pt)

  #set outline.entry(fill: line(
    length: 100%,
    start: (7.5pt / 2, 0pt),
    stroke: (dash: ("dot", 7.5pt)),
  ))

  #show outline.entry: it => {
    set text(weight: "bold") if it.level <= 2

    if it.level == 1 {
      v(2em, weak: true)
    }

    link(
      it.element.location(),
      it.indented(box(width: 5em, it.prefix()), it.inner()),
    )
  }

  #show outline.where(target: selector(heading)): it => {
    show outline.entry.where(level: 1): it => {
      set block(above: 2em)
      upper(it)
    }

    show outline.entry.where(level: 1): it => {
      set text(weight: "bold")
      upper(it)
    }

    show outline.entry.where(level: 2): it => {
      set text(weight: "bold")
      it
    }

    it
  }

  #show bibliography: it => [
    #show heading: set align(center)

    #show heading: it => [
      #it
      #v(1em)
    ]

    #it
  ]

  // #show figure.where(kind: image): set figure(supplement: [Figura])
  // #show figure.where(kind: table): set figure(supplement: [Tabela])
  // #show figure.where(kind: raw): set figure(supplement: [Código])

  // #set figure.caption(position: top, separator: [ — ])

  // // Blocos de código podem atravessar páginas.
  // #show figure.where(kind: raw): set block(breakable: true)

  #show raw: it => [
    #set text(font: FONTES.codigo, ligatures: true)
    #it
  ]

  #show table: block.with(stroke: (top: 1pt, bottom: 1pt))

  #set table(stroke: (_, y) => if y == 0 { (bottom: 0.5pt) })

  #show table.cell.where(y: 0): strong

  #set quote(block: true)

  #show quote.where(block: true): it => {
    set text(size: 10pt)
    set par(leading: 1em)
    set block(above: 3em, below: 3em)
    set rect(width: 100%, stroke: none)

    grid(
      columns: (4cm, 1fr),
      rows: 1,
      rect[], rect[#it],
    )
  }

  #capa(aluno, titulo, curso, local, data)

  #folha_de_rosto(aluno, orientador, titulo, natureza, local, data)

  #outline(title: "Lista de Figuras", target: figure.where(kind: image))

  #outline(title: "Lista de Tabelas e Quadros", target: figure.where(kind: table))

  #outline(title: "Lista de Códigos", target: figure.where(kind: raw))

  #outline(title: "Sumário")
  #metadata("fim_sumario") <fim_sumario>

  #body
]
