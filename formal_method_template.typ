#let project(course: "课程作业", number: int(0), name: "姓名", id: "PB2XXXXXXX",
             body) = {
    // Set the document's basic properties.
    let author = name + " " + id 
    let title = course + " " + str(number)
    set document(author: (author, ), title: title)
    set page(
        numbering: "1", 
        number-align: center,
        // Running header.
        header-ascent: 14pt,
        header: locate(loc => {
            let i = counter(page).at(loc).first()
            if i == 1 { return }
            set text(size: 8pt)
            grid(
                columns: (50%, 50%),
                align(left, title),
                align(right, author),
            )
        }),
    )
    set text(font: "Source Han Serif SC", lang: "en")
    show math.equation: set text(font: "New Computer Modern Math", weight: 400)

    // Set paragraph spacing.
    show par: set block(above: 1.2em, below: 1.2em)

    set par(leading: 0.75em)

    // Title row.
    align(center)[
        #block(text(weight: 700, 1.75em, title))
        
        #v(0.25em)

        #author

        #v(0.25em)
    ]

    // Main body.
    set par(justify: true)

    // Code
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )

    show raw.where(block: true): block.with(
        width: 100%,
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
    )

    body
}

#let question_counter = counter("question")
#let question_name = "题"

#let question(number: none) = {
    if number == none {
        strong([
            #question_counter.display(question_name + " 1.") 
            #v(-0.9em) 
            #line(length: 100%)
            #v(-0.6em)
        ])
        question_counter.step()
    } else {
        let number = question_name + " " + str(number) + "."
        strong([#number #v(-0.9em) #line(length: 100%) #v(-0.6em)])
    }
}

#let proof_line(formula, theory, x0, predicate_flag) = {
  if predicate_flag {
      columns(3)[
      #x0
      #colbreak()
      #formula
      #colbreak()
      #{ if theory == [p] {
        [premise]
      } else if theory == [a]{
        [assumption] 
      } else {
        theory
      }}
    ]
  } else {
    columns(2)[
      #formula
      #colbreak()
      #{ if theory == [p] {
        [premise]
      } else if theory == [a]{
        [assumption] 
      } else {
        theory
      }}
    ]
  }
}

#let inner_proof(start_index, start_line_num, end_line_num, predicate_flag, lines) = {
  let index = 0
  let line_num = start_line_num
  let pre_line = none
  let x_0_line = none
  let assuption_flag = false
  block(width: 100%)[
    #{
      let value_type = 0
      for value in lines.pos().enumerate() {
        index += 1
        if index < start_index {
          continue
        }
        if line_num < start_line_num and value != [+] and value != [x] {
          line_num += 0.5
          continue
        }
        else if line_num < start_line_num and (value == [+] or value == [x]) {
          line_num -= 0.5
          continue
        }
        if line_num >= end_line_num {
          return
        }
        if assuption_flag {
          assuption_flag = false
          rect(width: 100%, inset: (top: 0pt, bottom: 0pt, left: 10pt, right: 10pt), outset: (top: 5pt, bottom: 5pt))[#inner_proof(index + 1, line_num, line_num + value, predicate_flag, lines)]
          start_line_num = line_num + value
        } else if value_type == 1 {
          value_type = 0
          if value == [x] {
            x_0_line = pre_line
          } else {
            line_num += 1
            proof_line(pre_line, value, x_0_line, predicate_flag)
            x_0_line = none
          }
        } else if value != [+]{
          value_type = 1
          pre_line = value;
        } else {
          assuption_flag = true
        }
      }
    }
  ]
}

#let gen_line_code(row_num) = {
  block(width: 100%)[
    #{
      for i in range(row_num) {
        columns(1)[
          #{$#(i+1).$}
        ]
      }
    }
  ]
}

#let proof(..lines) = {
  let row_num = 0
  let predicate_flag = false
  
  for value in lines.pos().enumerate() {
    if value == [x] {
      row_num -= 0.5
      predicate_flag = true
    } else if value == [+] {
      row_num -= 0.5
    } else {
      row_num += 0.5
    }
  }
  grid(columns: (0.1fr, 0.9fr), gen_line_code(int(row_num)), inner_proof(0, 0, 9999, predicate_flag, lines))
}
