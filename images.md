## PDF/A and removing transparency from images

The PDF/A-1b standard does not allow transparency for images. This affects both .png and .pdf images. You can use the Linux command file to recognize .png files with transparency. "PNG image data, 64 x 64, 8-bit/color RGBA, non-interlaced". Images that do not have transparency (alpha channel) are listed as "RGB".

For PNG files, the ImageMagick tool magick (in older versions convert) can be used to remove transparency:

```
magick image.png -background white -alpha remove -alpha off image_nobg.png
```

For PDF files use PDF/A compliant images. Ghostscript can usually do the conversion (command line options vary with different versions)

```
gs -dPDFA -dBATCH -dNOPAUSE -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=2 -sOutputFile="figure-pdfa.pdf" "figure.pdf"
```

or convert to .png:

```
magick figure.pdf -background white -alpha remove -alpha off figure.png
```
The tool verapdf can be used to validate your .PDF file:

```
verapdf -f 1b main.pdf
```
