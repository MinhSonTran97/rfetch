# rfetch

A neofetch-style system information display tool for R with customizable themes.

## Installation

```r
remotes::install_github("MinhSonTran97/rfetch")
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

<img width="556" height="580" alt="Screenshot (151)" src="https://github.com/user-attachments/assets/ee6d4650-3846-4ff3-bb57-f88b5be96dd0" />

## Known Issues

- **Windows 11 displays as Windows 10**: This is by design for compatibility issues so that softwares doesn't stop installing because it thinks that Windows 11 is an unsupported operating system.

Inspired by [neofetch](https://github.com/dylanaraps/neofetch).
