# Portfolio Models

This directory contains all data models for the portfolio application, organized into separate files for better maintainability.

## File Structure

```
lib/models/
├── models.dart              # Barrel file - import this to get all models
├── portfolio_model.dart     # Main portfolio model
├── social_link.dart         # Social media links model
├── project.dart             # Project model
├── skill.dart               # Skill model
├── course.dart              # Course/certification model
├── experience.dart          # Work experience model
└── education.dart           # Education model
```

## Usage

### Import all models at once:

```dart
import 'package:portfolio/models/models.dart';

// Now you can use any model
final portfolio = PortfolioModel(
  name: 'John Doe',
  projects: [Project(...)],
  skills: [Skill(...)],
);
```

### Import specific models:

```dart
import 'package:portfolio/models/portfolio_model.dart';
import 'package:portfolio/models/project.dart';

final portfolio = PortfolioModel(
  projects: [Project(title: 'My App')],
);
```

## Models Overview

### 1. PortfolioModel
Main model containing all portfolio data.

**Fields:**
- Basic info: `id`, `profileImage`, `name`, `jobTitle`, `bio`, `email`, `phone`, `location`, `resumeUrl`
- Collections: `socialLinks`, `projects`, `skills`, `courses`, `experience`, `education`, `languages`

### 2. SocialLink
Social media and professional links.

**Fields:** `platform`, `url`, `icon`

### 3. Project
Portfolio projects with images and links.

**Fields:** `id`, `title`, `description`, `image`, `images`, `demoUrl`, `githubUrl`, `technologies`, `category`, `startDate`, `endDate`, `isFeatured`

### 4. Skill
Technical skills with proficiency levels.

**Fields:** `name`, `icon`, `image`, `proficiency`, `category`

### 5. Course
Online courses and certifications.

**Fields:** `id`, `title`, `description`, `image`, `instructor`, `platform`, `certificateUrl`, `completedDate`, `skills`, `rating`

### 6. Experience
Work experience and employment history.

**Fields:** `id`, `company`, `companyLogo`, `position`, `description`, `location`, `startDate`, `endDate`, `isCurrent`, `responsibilities`, `technologies`

### 7. Education
Educational background.

**Fields:** `id`, `institution`, `institutionLogo`, `degree`, `field`, `location`, `startDate`, `endDate`, `gpa`, `description`, `achievements`

## JSON Serialization

All models support JSON serialization:

```dart
// To JSON
Map<String, dynamic> json = portfolio.toJson();

// From JSON
PortfolioModel portfolio = PortfolioModel.fromJson(json);
```

## Example

```dart
import 'package:portfolio/models/models.dart';

final portfolio = PortfolioModel(
  name: 'John Doe',
  jobTitle: 'Flutter Developer',
  profileImage: 'assets/profile.jpg',
  skills: [
    Skill(
      name: 'Flutter',
      icon: 'assets/svg/Flutter.svg',
      proficiency: 95,
      category: 'Mobile Development',
    ),
  ],
  projects: [
    Project(
      title: 'E-Commerce App',
      description: 'Full-featured shopping app',
      image: 'assets/app.png',
      technologies: ['Flutter', 'Firebase'],
      isFeatured: true,
    ),
  ],
);

// Convert to JSON
final json = portfolio.toJson();

// Save to Firebase
await firestore.collection('portfolio').doc(userId).set(json);
```

## Benefits of This Structure

✅ **Modular** - Each model in its own file  
✅ **Maintainable** - Easy to find and update specific models  
✅ **Scalable** - Add new models without affecting others  
✅ **Clean** - Single responsibility per file  
✅ **Easy imports** - Use barrel file to import everything at once  

## Migration Note

If you were using the old single-file approach, simply update your imports:

```dart
// Old
import 'package:portfolio/models/portfolio_model.dart';

// New (recommended)
import 'package:portfolio/models/models.dart';
```

All models remain the same - only the file organization changed!
