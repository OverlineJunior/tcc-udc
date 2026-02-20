#import "constantes.typ": *

#let capa(aluno, titulo, curso, local, data) = [
  #set par(justify: false)
  #set align(center)
  #set rect(width: 100%, height: 100%, stroke: none)

  #grid(
    columns: 1,
    rows: (0.75fr, 0.6fr, 1fr, 1fr),
    rect[
      #set text(size: TAMANHOS_FONTE.grande, weight: "bold")
      #upper[Centro Universitário Dinâmica das Cataratas] \
      #upper[Curso de #curso]
    ],
    rect[#text(size: TAMANHOS_FONTE.corpo)[#upper(aluno)]],
    rect[#upper(text(size: TAMANHOS_FONTE.grande, weight: "bold")[#titulo])],
    rect[
      #set text(size: TAMANHOS_FONTE.pequeno)
      #set align(bottom)
      #upper(local) \
      #data
    ],
  )

  #pagebreak()
]

#let folha_de_rosto(aluno, orientador, titulo, natureza, local, data) = [
  #set par(justify: false)
  #set align(center)
  #set rect(width: 100%, height: 100%, stroke: none)

  #grid(
    columns: 1,
    rows: (2.5fr, 1.5fr, 1.5fr, 2fr),
    rect[#text(size: TAMANHOS_FONTE.corpo)[#upper(aluno)]],
    rect[#text(size: TAMANHOS_FONTE.grande)[#upper(titulo)]],
    grid(
      columns: (1fr, 1fr),
      rows: 1,
      [],
      rect[#align(left)[#text(
        size: TAMANHOS_FONTE.minusculo,
      )[
        #set par(leading: 0.4em, justify: true)
        #natureza \ \
        Orientador: #orientador
      ]]],
    ),
    rect[#align(bottom)[#text(size: TAMANHOS_FONTE.pequeno)[ #upper(local) \ #data]]],
  )

  #pagebreak()
]

// TODO! Fonte pode aparecer em outra página ao invés de ficar junto com a figura.
#let _figura-com-fonte(titulo, corpo, fonte, tipo) = {
  set figure(
    caption: titulo,
    gap: 0.7em,
    supplement: upper(tipo),
    kind: tipo,
  )
  set figure.caption(position: top, separator: [ — ])

  set par(spacing: 0.25em)

  figure(corpo)

  align(center, text(size: TAMANHOS_FONTE.minusculo)[FONTE: #fonte])
}

#let figura(titulo, corpo, fonte) = {
  _figura-com-fonte(titulo, corpo, fonte, "figura")
}

#let tabela(titulo, corpo, fonte) = {
  // TODO! E se for uma tabela que não se encaixa no modelo de "y = 0 => título de coluna"? O mesmo se aplica para quadros.
  set table(
    align: horizon,
    stroke: (_, y) => if y == 0 { (bottom: 1pt) },
  )
  show table: block.with(stroke: (top: 1pt, bottom: 1pt))
  show table.cell.where(y: 0): strong

  _figura-com-fonte(titulo, corpo, fonte, "tabela")
}

#let quadro(titulo, corpo, fonte) = {
  set table(align: horizon)
  show table: block.with(stroke: (top: 1pt, bottom: 1pt))
  show table.cell.where(y: 0): strong

  _figura-com-fonte(titulo, corpo, fonte, "quadro")
}

#let codigo(titulo, corpo, fonte) = {
  _figura-com-fonte(titulo, corpo, fonte, "código")
}
