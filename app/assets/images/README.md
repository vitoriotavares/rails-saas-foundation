# SaaS Foundation - Image Assets

This directory should contain your application's image assets.

## Required Images

### OpenGraph Image (`og-image.png`)
Create a 1200x630px image for social media sharing.

**Design Guidelines:**
- Use your brand colors
- Include your logo and app name
- Keep text large and readable
- Consider how it will look on different platforms (Twitter, Facebook, LinkedIn)

**Tools for Creation:**
- [Canva](https://canva.com) - Free templates available
- [Figma](https://figma.com) - Professional design tool
- [Photoshop](https://adobe.com/photoshop) - Industry standard

### Favicon Files
The following favicon files are recommended:

- `icon.svg` - Vector icon (already included)
- `icon.png` - 192x192px PNG (already included)
- `apple-touch-icon.png` - 180x180px for iOS
- `favicon.ico` - 32x32px ICO format

**Favicon Generation:**
- [RealFaviconGenerator](https://realfavicongenerator.net/)
- [Favicon.io](https://favicon.io/)

### Logo Files
Create logo variations:

- `logo.svg` - Vector logo for best quality
- `logo.png` - High-resolution PNG
- `logo-dark.svg` - Dark mode version
- `logo-light.svg` - Light mode version

## Optimization

Remember to optimize all images for web:

- Use WebP format when possible
- Compress PNG/JPG files
- Use SVG for icons and logos
- Consider responsive images for different screen sizes

## Image Processing

Rails uses ImageProcessing gem (via libvips) for image transformations.
You can use Active Storage variants for dynamic resizing.