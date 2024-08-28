<a name="readme-top"></a>

<!-- PROJECT Title -->
<h1 align="center">
pdfmagick
</h3>

<div align="center">
  <a href="https://github.com/tfoerst3r/particle_conversion">
    <img src="./docs/images/logo_pdfmagick.png" alt="Logo" width="120">
  </a>
</div>

<p align="center">
A TUI for a collection of several tools to manipulate PDFs including embedding ocr text.
</p>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>


<!--===================-->
<!-- ABOUT THE PROJECT -->
<!--===================-->
## About the Project
<!-- Some details about the motivation of the project-->

Streamline several tools for my workflow of archiving documents from scanner to pdf.

<!--=================-->
<!-- GETTING STARTED -->
<!--=================-->
## Getting Started
<!-- what does the script/program do-->

### Prerequisites
The current setup utilizes:

- `ocrmypdf` (snap, v16.4.2)
- `pdftk` (v3.3.3)
- `magick` (v7.1.1)

Please have this or newer installed on your system.

### Installation

This tools utilizes `bashly`, a bash CLI Generator ([LINK](https://github.com/DannyBen/bashly)). You can create the script my using the following command in root:

``` bash
$ bashly generate
```

This will generate a bash script called `pdfmagick`. Now you can put it in a location your system will automatically mount. For example:

``` bash
$ mv pdfmagick ~/bin/
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

**Syntax**

``` bash
$ pdfmagick COMMAND
$ pdfmagick [COMMAND] --help
```

In your shell you can use:

``` bash
$ pdfmagick --help
```

**COMMANDs**

Current commands, available:

- `ocr`
- `zip`
- `pdf2tif`
- `tif2pdf`
 

**Example**

Imagine you have scanned a document, consisting of two files, one for odd and another for even pages. For improving quality and reducing file size, you want to use `scantailer`, a tool for post-processing scanned documents.

1. Scanned document
1. For one sided scans, you need to merge odd and even numbered pages via:
    
    ``` bash
    $ pdfmagick zip odd.pdf even.pdf
    ```

1. To be able to use `scantailor` you need tif files, therefor you 
    
    ``` bash
    $ pdfmagick pdf2tif input.pdf
    ```

1. Utilize `scantailor` (external program, which needs tif inputs)
1. Merge all created new `*.tif` files

    ``` bash
    $ pdfmagick tif2pdf out.pdf *.tif
    ```
1. Finally perform ocr including the embedding of the ocr in the pdf

    ``` bash
    $ pdfmagick ocr out.pdf --lang eng
    ```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT and CC-BY-4.0 Licenses. See `LICENSE.md` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

