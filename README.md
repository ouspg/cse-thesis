## CSE/BME/BA thesis

This LaTeX template is for BSc and MSc theses of the CSE, BME and BA degree
programmes at the ITEE faculty of the University of Oulu.

It has been used by various people since the late 1990's, and has slowly improved over time.

The template produces a **PDF/A-4f** and **PDF/UA-2** compliant PDF file, which can be uploaded directly to the successor of Laturi.

Transparency in images is supported and does not need to be removed.

We kindly ask students using this template to improve it and share the
improvements so that others may benefit.

This template is distributed to students via Overleaf, and
https://github.com/ouspg/cse-thesis is synchronized with it. 
Issues and pull requests can be made to GitHub.

This work is licensed under a Creative Commons "Attribution 4.0
International" license.

### Contributions

Contributors to the template include:

 * Mika Korhonen (original author)
 * Pekka Pietikäinen
 * Simo Hosio
 * Christian Wieser
 * Teemu Tokola
 * Juha Kylmänen
 * Joonas Sarajärvi
 * Tuomas Holmberg
 * Tuomas Varanka

### FILES AND FOLDERS
 * main.tex
   * The main file. Input your information and files here.
 * main-finnish.tex
   * Minimal example showing Finnish chapter names.
 * Chapters/
   * All chapters included from main.tex. To add a chapter, create a .tex
     file here and \input it in main.tex.
 * Figures/
   * Place figures here. A graphicspath is already set.
 * Gallery/
   * Example LaTeX snippets for things some theses may need.
 * citations.bib
   * BibTeX citations. Use a reference manager such as Zotero and export
     with BetterBibTeX for best results.
 * copyright-allrightsreserved.tex, copyright-ccby40.tex
   * Copyright page contents for "All rights reserved" and CC-BY-4.0.
 * dithesis.cls, dithesis.sty
   * Document class and style package.
 * doclicense-di.sty, doclicense-finnish.ldf
   * CC license support: adds alt-text to the license badge image and
     Finnish translations for doclicense.
 * LICENSE
   * CC-BY-4.0 license for this template.
 * README.md
   * This file.

### LoC
 * 2026-06-10 Pekka Pietikäinen
   * PDF/A-4f + PDF/UA-2 output via pdfmanagement/tagpdf, replacing pdfx
     * \DocumentMetadata enables full tagged PDF (tagging=on, mathml-SE)
     * Metadata (title, author, abstract, keywords, copyright) written via
       \hypersetup; .xmpdata file approach removed
     * LuaLaTeX supported (lualatex on devel branch, pdflatex on main)
   * Alt text for figures via alt= key in \includegraphics (PDF/UA-2 req.)
     * Alt text now documented in the accessibility section
   * Transparency in images is now allowed (PDF/A-4f/2b support it)
     * Removed pre-processed doclicense-images/ directory
     * Removed transparency removal instructions
   * algorithm2e: suspend/resume tagging to avoid UA-2 structure errors
   * Decimal comma math hack removed (broke \vdots and similar)
   * CI: verapdf updated to v1.30.2, validates PDF/A-4f and PDF/UA-2

 * 2026-04-01 Pekka Pietikäinen
   * Update Turnitin link for 2026 (and note it changes annually)
   * Use citestyle=numeric-comp -> The official IEEE [1], [16], [17], [18]
     -> [1, 16-18]. If you need page numbers for one citation (or want the
     official IEEE style), use ~\cite{ref1},~\cite[p. 55]{ref2},~\cite{ref3}

 * 2026-01-15 Pekka Pietikäinen
   * Add Gallery/aiusage.tex with Finnish/English examples for one author
     no AI used
   * Finnish Abstract page used p. not s. for document metadata, now
     translates properly (Fixes #21)
   * Clarify that your employer can also have image copyright

 * 2025-08-19 Pekka Pietikäinen
   * Changes to the instructions:
     * "Tiivistelmä" is now required for all theses. In a thesis written
       in English, abstract precedes "tiivistelmä" and vice versa.
     * Unification with changes done to 2025 ECE thesis instructions:
       * List of abbreviations and symbols: Greek letter italicisation rules
       * Tables must be in text format – not an image
       * Margins are now 2.5/2.5/2.5/3.0 cm (online)
       * Equation guidelines updated to match ECE
       * Font was Latin Modern in the text, but the template always used Times
       * Figure copyright location (was in footnote, now copyright page or caption)
       * References now IEEE style; Finnish translation is "Lähteet" (was "Viiteet")
     * Copyright and citation style
       * Copyright page added to thesis
       * Instructions for proper attribution for reuse/modification of images
     * Turnitin is now mandatory
     * BSc group thesis contributions now in Introduction with AI use
   * Template changes:
     * Major cleanup removing obsolete packages and using modern replacements
     * PDF/A-1b output
     * Abstract, keywords and metadata automatically included in PDF
     * Support for CSE/BA/BME theses
     * biblatex/biber for bibliography management

 * 2025-06-02 Joni Kemppainen & Pekka Pietikäinen
   * PDF/A support for template
   * Add notes about transparency and explicit licenses for image captions

 * 2025-02-28 Simo Hosio
   * Instructions for Authors contribution and AI usage section

 * 2019-06-06 Tuomas Holmberg and Tuomas Varanka
   * Cleanups
   * Moved github version to Overleaf
   * Added an example of algorithm and an example equation
   * Added option for multiple authors
   * Hyperref for table of contents
   * Numerous quality of life updates

 * 2014-05-05 Joonas Sarajärvi
   * Cleanups

 * 2014-03-10 Juha Kylmänen
   * New front page

 * 2013 Juha Kylmänen
   * Changed \chapter's \newpage to \clearpage
   * Added [hyphens] to url package for long url handling
   * Added multirow package
   * Makefile for pdflatex and bibtex
   * Abbreviations autosorted by Makefile
