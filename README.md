## cse-thesis

This LaTeX -template is for BSc and MSc theses of the CSE, BME and BA degree
programmes at the ITEE faculty of the University of Oulu.

It has been used by various people since the late 1990's, and has
slowly improved over time. It  still somewhat rough at the edges,
but hopefully will be helpful in reducing some of the pain involved in
writing a diploma thesis.

The current version of the template produces PDF/A-1b compliant PDF file,
which can directly be uploaded to Laturi (Muuntaja is NOT required).
This requires that transparency is removed from all images in your thesis.
Instructions for doing this are included in [images.md](images.md).

We kindly ask for students using this template to improve this template,
and share the improvements, so that others may benefit.

This template is distributed to students via Overleaf, and
https://github.com/ouspg/cse-thesis is synchronized with it. Issues
and pull requests can be made to GitHub.

This work is licensed under a Creative Commons “Attribution 4.0
International” license.

### Contributions

Contributors to the template include:

 * Mika Korhonen (original author)
 * Pekka Pietikäinen
 * Christian Wieser
 * Teemu Tokola
 * Juha Kylmänen
 * Joonas Sarajärvi
 * Tuomas Holmberg
 * Tuomas Varanka

### FILES AND FOLDERS
 * Chapters
   * This folder holds all the chapters that are added to the main file. To create more chapters simply create a .tex file in the chapters folder and input it in the main.tex file.
 * Figures
   * Place the necessary figures in your thesis here. A path to the figures has already been set when using "\begin{figure}...". Look for an example of how to use figures from Figure 1 and 2.
 * Gallery
   * This contains examples LaTeX snippets for doing various things that some theses might require. 
 * citations.bib
   * This holds all the bibtex citations. Use a reference manager like Zotero and use the "bibtex" form of citation when exporting from it. 
 * dithesis.sty
   * This is a package holds most of the style.
 * dithesis.cls
   * Similar to dithesis.sty, holds scripts and style.
 * main.tex
   * The main file. Input your information and files here.
 * ieee.bbx v1.4e 2025-03-14
   * This is needed to make @online citations comply with the IEEE style. TexLive 2025 should ship this, so can be removed once Overleaf has it
 * doclicense-csetemplate.sty, doclicense-images, doclicense-finnish.ldf
   * PDF/A-compatible CC license logos and .sty-file that looks for them in separate directory
     * Generated with gs -dPDFA -dBATCH -dNOPAUSE -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=2 -sOutputFile="$@" "$@.in.pdf"
   * Finnish translations to doclicense
 * images.md
   * Instructions on removing transparency from your images
 * README.md
   * This file!

### LoC
 * 2025-08-15 Pekka Pietikäinen
  * Changes to the instructions:
    * “Tiivistelmä” is now required for all theses. In a thesis written in English, abstract precedes “tiivistelmä” and vice versa.
    * List of abbreviations and symbols:
      * The changes in the italicisation of Greek letters are also reflected in this section.
      * ” Greek letters are not italicized.” => ”The lowercase Greek letters used as symbols of quantities are italicized, but uppercase letters are not italicized (e.g. δ vs. Δ).”
    * Tables must be in text format – not an image.
    * Margins are now 2.5/2.5/2.5/3.0 cm (online), for bound (not just printed) versions of the thesis the old 4.5cm left margin (2.0 right) can chosen from the template.
    * Font was Latin Modern in the text, but the template always used Times
    * The necessary references are included in the figure captions. Copyright information is also added to the end of the caption. Figures should preferably be placed at the top or bottom of the page, however, structured naturally.
    * Copyright
      *  Copyright page has been added, and proper attribution for reuse/modification of image by others has been included in the instructions. More information in Chapter 3.7.
    * The sources are now cited according to the IEEE model (was used in the text but not the template). Reference list was custom ACTA Oulu, now IEEE.
      * For example, ”[1, 2, 5]” is now ”[1], [2], [5]”. More information and examples in Chapter 4.6.

  * Template changes:
    * Major cleanup removing obsolete packages and using modern replacements
    * PDF/A-1b output. If no transparent images (PDF/PNG) are used, Muuntaja is not required, this is also recommended, since Muuntaja might break the thesis in other ways.
    * Abstract, keywords and other metadata automatically included in PDF
    * Support for CSE/BA/BME theses
    * biblatex/biber for bibliography management
      * Citations exported from Zotero should have doi, accessed etc. correctly!
      
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
   * Changed \chapter's \newpage to \clearpage to prevent floats from wandering to the beginning of the next chapter
   * Added [hyphens] to the url package to prevent margin overflow with long urls
   * Added multirow package to make multirow and multicolumns possible
   * Added some helpful source code comments
   * Makefile for pdflatex and bibtex to automate pdf compilation
   * Abbreviations are autosorted by the Makefile
   * Added a bit of extra padding to the sample table

### TODO   
 * See Issues (are the ones below relevant anymore?)

