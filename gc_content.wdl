version 1.0

task gc_content {
  input {
    File input_file
  }
  command {
    cat ${input_file} | wc -l > line_count
  }
  output {
    Int line_count = read_int("line_count")
  }
  runtime {
    docker: "ubuntu:latest"
  }
}

workflow gc_content_wf {
  input {
    File input_file
  }
  call gc_content {
    input:
      input_file = input_file
  }
  output {
    Int line_count = gc_content.line_count
  }
}
