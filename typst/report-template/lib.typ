#import "@preview/codelst:2.0.2": *

#let textL = 1.5em
#let textM = 1.2em
#let fontSerif = "Harano Aji Mincho"
#let fontSan = ("Moralerspace Neon", "Menlo", "Harano Aji Gothic")
#let fontHeading = "Harano Aji Gothic"
#let fontMath = "New Computer Modern Math"

// title, course, authors は必須。date は省略すると日付欄自体を出さない
// （datetime.today() は環境によって現在時刻の取得に失敗しコンパイルエラーになるため
//  使わない。日付を出す場合は呼び出し側で date: "2026年8月16日" のように直接渡す）。
// bib は省略すると参考文献セクション自体を出さない。渡す場合は呼び出し側で
// bibliography("bib.yaml", ...) を評価した結果（content）を渡すこと。
// bibliography() のパス引数はこのファイル基準で解決されるため、テンプレート内から
// 直接呼ぶとレポート側の bib.yaml を見つけられない。
#let project(title: none, course: none, authors: (), date: none, bib: none, body) = {
    // Heading
    set heading(numbering: "1.1")
    show heading: it => text(
        font: fontHeading,
        weight: "medium",
        lang: "ja",
    )[#pad(bottom: 0.5em, it) #par(text(size: 0pt, ""))]

    // Figure
    show figure: it => pad(y: 1em, it)
    show figure.caption: it => text(it, lang: "ja")

    // Table
    set table(stroke: none)
    show figure.where(kind: table): set figure.caption(position: top)

    // Equation
    set math.equation(numbering: "(1)", number-align: bottom)
    set math.mat(delim: "[")
    show math.equation: set text(font: fontMath)

    // Code
    show raw: set text(font: fontSan, size: 0.8em)
    show raw.where(block: true): set par(leading: 0.5em)

    // Outline
    show outline.entry: set text(font: fontSerif, lang: "ja")
    show outline.entry.where(level: 1): it => {
        v(0.2em)
        set text(weight: "semibold")
        it
    }

    // Set the document's basic properties.
    set document(author: authors.map(a => a.name), title: title)
    set text(font: fontSerif, lang: "ja")
    set par(justify: true, first-line-indent: 1em)
    set page(numbering: "1", number-align: center, paper: "a4", margin: 2.5cm)

    // Title row.
    align(center)[
        #block(text(weight: 500, textL, title))
        #block(text(weight: 400, textM, course))
        #v(1em, weak: true)
        #if date != none [#date]
    ]

    // Author information.
    pad(
        grid(
            columns: (1fr,) * calc.min(3, authors.len()),
            gutter: 1em,
            ..authors.map(author => align(center)[
                #author.affiliation\
                #author.number #author.name
            ]),
        ),
    )
    set text(font: fontSerif, size: 1em, weight: "light", lang: "ja")

    body

    if bib != none {
        // 欧文文献の書式が日本語化されないよう、参考文献のみ言語を英語に切り替える
        set text(lang: "en")
        bib
    }
}
