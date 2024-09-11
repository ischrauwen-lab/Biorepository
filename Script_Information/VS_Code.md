# Visual Studio Code

* Created by Rui Dong, August 2023

## About

Visual Studio Code (famously known as VS Code) is a free open source text editor by Microsoft. VS Code is available for Windows, Linux, and macOS. The editor is relatively lightweight; yet it includes some powerful features that have made VS Code one of the most popular development environment tools in recent times. It supports various programming languages, making it suitable for different development requirements.

## Installation

The latest version can be downloaded from [official website](https://code.visualstudio.com), and it is pretty straight forward. After installation, you can follow the [videos](https://code.visualstudio.com/docs/getstarted/introvideos) to start your journey!

## Extensions

One of the best things I love about VS Code is that it provides millions of extensions to customize it in your own way. It is similar to the Chrome browser extensions. You can find the "Extensions" icon on the left-side toolbar after you open VS Code. Here is a list of extensions that I find very useful:

- Jupyter
- Markdown All in One
- Prettier - Code formatter
- Python
- R
- Rainbow CSV
  
Please note that if you install too many extensions, VS Code will take a longer time on initial startup. Under the "LOCAL-INSTALLED" in the extensions, you can actually see how much time each extension requires to load (generally several ms). I suggest to check this from time to time, and remove those extensions that you haven't used for a long time and take a long time loading. You can also read [this](https://www.roboleary.net/2021/08/10/vscode-how-many-extensions-should-i-use.html) for more information.

## Connect to remote server

When you open your VS Code, it lands by defaut on your local computing environment. To connect to a remote server via SSH, please install this extension: [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh).

To connect to the remote computer such as the cluster login node, go to `View -> Command Palette` (on Mac, you can use `cmd+Shift+p`), then type `Remote SSH Connect to Host` after `>`. Select the top option that pops up, which will take you to a dialog box to select configured SSH Host. For first time users, you should click on "Add New SSH Host". Follow the prompt to put in command `ssh username@url` and enter password to the dialog box that pops up. VS Code may install a few extensions for first time use which will take longer to connect. After you are connected, you should see a line in the Status Bar (at the left bottom, if not seen, go to `View -> Appearance -> Status Bar`) indicating you are connected.

At this point, you can find the "Remote Explore" on the left-side toolbar of the VS Code window. Click on it and select the remote host to start browsing. You can edit remote text files, and with JupyterLab extension, edit Jupyter Notebooks. 

## Jupyter Notebooks with VS Code

[This document](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_variable-explorer-and-data-viewer) provides a good reference for Jupyter Notebook in VS Code. Here is a brief setup guide:

1. You need to install VS Code extensions `Jupyter`, `Python` and `R`. To edit Jupyter Notebook on remote computer you also need to install these extensions again to the remote computer, after you connect to the environment.
2. To use `R` properly, you may also need to install the R Language Server library: `micromamba install r-languageserver`.
3. After you open a Jupyter Notebook, you can find on the top right corner options to `Select Kernel` for the version of kernel you choose to load. Make sure you select kernels from the software environment you prefer. 

For more details on managing the jupyter kernels in VS Code, please refer to [here](https://code.visualstudio.com/docs/datascience/jupyter-kernel-management#_jupyter-kernels).

**Note:** even though you can run Jupyter Notebook from VS Code, please do not do so for heavy computations because unlike connecting to remote host via JupyterLab, the VS Code approach only connects to the login node where you may run quick computing jobs but you should be mainly editing text documents. Compared to JupyterLab, VS Code connection is typically more stable and the coding environment it provides is more versatile than JupyterLab.
