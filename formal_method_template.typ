#let proof_line(formula, theory) = {
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

#let inner_proof(start_index, start_line_num, end_line_num, lines) = {
  let index = 0
  let line_num = start_line_num
  let pre_line = none
  let assuption_flag = false
  block(width: 100%)[
    #{
      let value_type = 0
      for value in lines {
        index += 1
        if index < start_index {
          continue
        }
        if line_num < start_line_num {
          line_num += 0.5
          continue
        }
        if line_num >= end_line_num {
          return
        }
        if assuption_flag {
          assuption_flag = false
          rect(width: 100%, inset: (top: 0pt, bottom: 0pt), outset: (top: 5pt, bottom: 5pt))[#inner_proof(index + 1, line_num, line_num + value, lines)]
          start_line_num = line_num + value
        }
        else if value_type == 1 {
          value_type = 0
          line_num += 1
          proof_line(pre_line, value)
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
  grid(row-gutter: 13.4pt, ..{ // 手动调整这个 row-gutter ，使得行号与公式对齐
    for value in range(row_num) {
      ([$#(value + 1).$], )
    }
  })
}

#let proof(row_num, ..lines) = {
  grid(columns: (0.1fr, 0.9fr), gen_line_code(row_num), inner_proof(0, 0, 9999, lines))
}

// 样例

#proof(8,                 // 总行号
  $q->r$, [p],            // premise 的缩写形式 [p]
  [+], 5,                 // 建立一个持续 5 行的 assuption
  $p->q$, [a],            // assumption 的缩写形式 [a]
  [+], 3,                 // 建立一个持续 3 行的 assuption
  $p$, [a],
  $q$, [$-> e$ 2,3],
  $r$, [$-> e$ 1,4],
  $p->r$, [$-> i$ 3-5],
  $(p->q)->(p->r)$, [$-> i$ 2-6],
)
