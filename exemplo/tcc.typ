#import "../src/lib.typ": *
#import "@preview/codly:1.3.0": codly-init

#let aluno = "Francisco Sebastiany Junior"
#let orientador = "Prof. Me. Luciano S. Cardoso"
#let titulo = "Front-End para uma Linguagem de Programação Orientada ao Entity Component System"
#let curso = "Ciência da Computação"
#let natureza = [Trabalho de Conclusão de Curso apresentado como requisito obrigatório para obtenção do título de Bacharel em #curso do Centro Universitário Dinâmica das Cataratas.]
#let local = "Foz do Iguaçu"
#let data = "2025"

#show: abnt_udc.with(
  titulo,
  aluno,
  curso,
  orientador,
  natureza,
  local,
  data,
)
#show: codly-init

#include "capitulos/introducao.typ"

#include "capitulos/fundamentacao.typ"

#include "capitulos/metodologia.typ"

#bibliography(
  "refs.yml",
  title: "Referências",
  style: "associacao-brasileira-de-normas-tecnicas",
)
