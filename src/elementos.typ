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

#let figura(titulo, imagem, fonte) = {
  set figure(caption: titulo, gap: 0.7em, supplement: [FIGURA])
  set figure.caption(position: top, separator: [ — ])
  set stack(dir: ttb, spacing: 0.7em)
  set align(center)

  figure(
    stack(
      imagem,
      text(size: TAMANHOS_FONTE.minusculo)[FONTE: #fonte],
    ),
  )
}

#let figura_legendada(titulo, corpo, ..legendas) = {
  let arg_num = legendas.pos().len()

  set figure(caption: titulo)
  set stack(dir: ttb, spacing: 1em)

  if arg_num == 1 {
    figure(stack(
      corpo,
      align(start, text(size: 10pt, legendas.at(0))),
    ))
  } else if arg_num == 2 {
    figure(stack(
      corpo,
      align(start, text(size: 10pt, legendas.at(0))),
      align(start, text(size: 10pt, legendas.at(1))),
    ))
  } else if arg_num == 3 {
    figure(stack(
      corpo,
      align(start, text(size: 10pt, legendas.at(0))),
      align(start, text(size: 10pt, legendas.at(1))),
      align(start, text(size: 10pt, legendas.at(2))),
    ))
  } else {
    panic("Número de legendas não suportado.")
  }
}
