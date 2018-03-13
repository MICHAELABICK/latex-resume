This repository contains my latex resume and cover letters. It also contains a Makefile, useful for efficiently building PDFs.

# Creating a Resume
Resume source files are stored in the `resume/` directory and cover letters in the `cover_letter` directory, where mine are currently. You can follow my format to create your own Tex resume and cover letters.

# Making PDFs
The Makefile will need both `pdflatex` and `latexmk`. First install these programs, then make a resume PDF using the command,

```sh
make resumes/resume_name.pdf
```

,replacing "resume_name" with the name of the Tex file you would like to compile. A cover letter PDF could be built using the command,

```sh
make cover_letters/cover_letter_dir/cover_letter_name.pdf
```

or, just make the entire project using

```sh
make all
```
