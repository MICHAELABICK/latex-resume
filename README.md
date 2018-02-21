This repository contains my latex resume and cover letters. It also contains a Makefile, useful for efficiently building PDFs.

# Making PDFs
The Makefile will need both `pdflatex` and `latexmk`. First install these programs, then make the resume using the command,

```sh
make resumes/resume.tex
```

A cover letter could be built using the command,

```sh
make cover_letters/cover_letter_dir/cover_letter_name.tex
```

or, just make the entire project using

```sh
make all
```
