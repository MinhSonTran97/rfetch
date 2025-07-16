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

<img width="920" height="836" alt="Screenshot (150)" src="https://github.com/user-attachments/assets/70b28aeb-f0a9-4cb8-b44a-cae0f938cf7a" />

Inspired by [neofetch](https://github.com/dylanaraps/neofetch).
