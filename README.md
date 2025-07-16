# rfetch

A neofetch-style system information display tool for R with customizable themes.

## Installation

```r
remotes::install_github("yourusername/rfetch")
```

## Usage

```r
library(rfetch)

# Basic usage
rfetch()

# Use different themes
rfetch(theme = "Matrix")
rfetch_theme(name = "Fire")

# Custom colors
rfetch(label_col = "31", value_col = "37")
```

## Available Themes

`Default`, `Mono`, `Rainbow`, `Matrix`, `Fire`, `Ocean`, `Sunset`, `Forest`, `Vintage`, `Neon`, `Minimal`, `Pastel`

## Functions

- `rfetch()` - Display system info with logo
- `rfetch_theme()` - Manage color themes  
- `rfetch_info()` - Get system information

## Example Output

```
:@@@@@@@@@@%%#+-     User: abc
:@@@@@@@@@@@@@@@#    Host: laptop
:@@@@@=   .+@@@@@+   OS: Windows 10
:@@@@@-     @@@@@*   RStudio: 2023.12.1
:@@@@@=   .+@@@@%.   R: 4.3.2
:@@@@@@@@@@@@@#=.    Packages: 157
:@@@@@@@@@@@@@#-     Theme: Default
:@@@@@=  .=@@@@@#    
:@@@@@-    .%@@@@%.  ████████████
:@@@@@-     .%@@@@%. ████████████
:@@@@@-      .%@@@@#
```

Inspired by [neofetch](https://github.com/dylanaraps/neofetch).
