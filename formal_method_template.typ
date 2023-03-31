#let proof_line(formula, theory, x0) = {
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
}

#let inner_proof(start_index, start_line_num, end_line_num, lines) = {
  let index = 0
  let line_num = start_line_num
  let pre_line = none
  let x_0_line = none
  let assuption_flag = false
  block(width: 100%)[
    #{
      let value_type = 0
      for value in lines {
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
          rect(width: 100%, inset: (top: 0pt, bottom: 0pt), outset: (top: 5pt, bottom: 5pt))[#inner_proof(index + 1, line_num, line_num + value, lines)]
          start_line_num = line_num + value
        } else if value_type == 1 {
          value_type = 0
          if value == [x] {
            x_0_line = pre_line
          } else {
            line_num += 1
            proof_line(pre_line, value, x_0_line)
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

#let proof( ..lines) = {
  let row_num = 0
  for value in lines {
    if value == [+] or value == [x] {
      row_num -= 0.5
    } else {
      row_num += 0.5
    }
  }
  grid(columns: (0.1fr, 0.9fr), gen_line_code(int(row_num)), inner_proof(0, 0, 9999, lines))
}
