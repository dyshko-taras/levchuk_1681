# Sports Prediction App Design System

## Overview
This design system is optimized for a Flutter Android sports prediction application with a dark theme aesthetic focused on clarity, engagement, and data visualization.

## Color Palette

### Primary Colors

**Primary Black** `#000000`
- Usage: Main background, primary surfaces
- Flutter: Color(0xFF000000)

**Success Green** `#00DD70`
- Usage: Success states, correct predictions, primary actions
- Flutter: Color(0xFF00DD70)

**Warning Yellow** `#FAD749`
- Usage: Pending states, warnings, highlights
- Flutter: Color(0xFFFAD749)

**Error Red** `#FF5555`
- Usage: Error states, missed predictions, destructive actions
- Flutter: Color(0xFFFF5555)

**Card Dark** `#161616`
- Usage: Card backgrounds, secondary surfaces
- Flutter: Color(0xFF161616)

**Border Gray** `#323232`
- Usage: Borders, dividers, inactive elements
- Flutter: Color(0xFF323232)

**Text White** `#FFFFFF`
- Usage: Primary text, labels, headings
- Flutter: Color(0xFFFFFFFF)

**Text Gray** `#727272`
- Usage: Secondary text, muted content
- Flutter: Color(0xFF727272)

**Accent Blue** `#38B6FF`
- Usage: Links, information states, predictions
- Flutter: Color(0xFF38B6FF)

**Accent Orange** `#FF8438`
- Usage: Highlights, special features, achievements
- Flutter: Color(0xFFFF8438)


## Typography
- **Primary Font**: Inter
- **Font Weights**: 
  - Regular (400): Body text, descriptions
  - Medium (500): Labels, secondary headings
  - Semi Bold (600): Important labels, status text
  - Bold (700): Action buttons, primary CTAs
  - Extra Bold (800): Main headings, titles
  - Black (900): Hero text, major metrics

### Font Sizes (Flutter)
- **Hero**: 27.0 (TextStyle fontSize)
- **Title**: 18.0 (TextStyle fontSize)
- **Heading**: 16.5 (TextStyle fontSize)
- **Subheading**: 15.0 (TextStyle fontSize)
- **Body**: 13.5 (TextStyle fontSize)
- **Caption**: 12.0 (TextStyle fontSize)
- **Small**: 10.5 (TextStyle fontSize)
- **Micro**: 9.0 (TextStyle fontSize)

## Component Guidelines

### Cards
- **Background**: #161616
- **Border Radius**: 15px (BorderRadius.circular(15))
- **Shadow**: BoxShadow with offset (0, 1.5), blur 3.0, color black25%
- **Padding**: 15px (EdgeInsets.all(15))

### Buttons
- **Primary**: Background #00DD70, text black, height 45px
- **Secondary**: Border #color, background transparent, text #color
- **Destructive**: Background #FF5555, text white
- **Border Radius**: 6px (BorderRadius.circular(6))

### Status Indicators
- **Success**: #3DFF37 (green circle with checkmark)
- **Error**: #FF5555 (red circle with X)
- **Pending**: #E1E1E1 (gray circle with clock)

### Badges/Chips
- **Achievement**: Rounded rectangles with icon and count
- **Background**: Semi-transparent overlay of accent color
- **Border Radius**: 6px
- **Inner Shadow**: Inset shadow for depth

## Layout Guidelines

### Spacing Scale (Flutter EdgeInsets)
- **XS**: 6.0
- **SM**: 9.0
- **MD**: 15.0
- **LG**: 24.0
- **XL**: 36.0

### Grid System
- **Container margins**: 15px from screen edges
- **Card spacing**: 15px between cards
- **Grid items**: 3 columns for statistics, 2 for achievements

## Interaction States

### Button States
- **Default**: Full opacity
- **Pressed**: 0.8 opacity, slight scale (0.95)
- **Disabled**: 0.5 opacity

### Card States
- **Default**: Elevation 2
- **Hover/Focus**: Elevation 4
- **Pressed**: Elevation 1

## Usage Examples for LLM Integration

When generating Flutter code:
1. Use MaterialApp with dark theme
2. Apply consistent color scheme from this palette
3. Use Card widgets for content grouping
4. Implement proper spacing using SizedBox and EdgeInsets
5. Use Inter font family throughout (GoogleFonts.inter())
6. Apply border radius consistently (6px for buttons, 15px for cards)
7. Use proper elevation and shadows for depth
8. Implement status colors for feedback states

## Accessibility
- Ensure minimum contrast ratio of 4.5:1 for text
- Use semantic colors consistently
- Provide alternative text for icons
- Ensure touch targets are minimum 44px
- Support system font scaling
