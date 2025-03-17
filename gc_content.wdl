version 1.0

task calculate_gc_content {
  input {
    File fasta_file
    File script_file  # This will be our calculate_gc.py file
  }

  command <<<
    # Optionally install dependencies (or you can bake these into your Docker image)
    apt-get update && apt-get install -y python3-pip && pip3 install --no-cache-dir biopython

    # Run the external Python script
    python3 ~{script_file} ~{fasta_file}
  >>>

  output {
    File gc_content_output = stdout()
  }

  runtime {
    docker: "python:3.9-slim"
    memory: "1GB"
  }
}

workflow gc_content_workflow {
  input {
    File input_fasta
    File my_script  # Our calculate_gc.py file
  }

  call calculate_gc_content {
    input:
      fasta_file = input_fasta,
      script_file = my_script
  }

  output {
    File gc_results = calculate_gc_content.gc_content_output
  }
}
