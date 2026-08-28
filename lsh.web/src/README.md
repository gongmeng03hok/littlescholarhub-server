# Little Scholars Hub — Expo App

Universal app (iOS · Android · Web) built with Expo Router + React Native.

## Step 1: Install

```bash
npm install
```

## Step 2: Configure environment

```bash
# .env is already created — edit API URL if needed:
echo "EXPO_PUBLIC_API_URL=https://www.littlescholarhub.com/api" > .env
```

## Step 3: Run

```bash
# Web (browser)
npm run web

# iOS simulator
npm run ios

# Android emulator
npm run android

# Expo Go app (scan QR)
npm start
```

## Step 4: Build for production

```bash
# Web (static export)
npm run build:web

# Native (via EAS)
eas build --platform ios
eas build --platform android
```

## Project structure

```
app/
  _layout.tsx          Root layout + font loading + QueryClient
  index.tsx            Auth guard → redirect by role
  (auth)/
    landing.tsx        Full landing page (mirrors reference portal)
    login.tsx          Email/password login
    register.tsx       Registration + language selection
    kid-select.tsx     Child picker + PIN entry
  (parent)/
    _layout.tsx        Parent tab navigator (5 tabs)
    index.tsx          Dashboard
    content.tsx        Worksheet browser
    story.tsx          Story reader
    progress.tsx       Progress + charts
    settings.tsx       Family settings + children management
    assessment.tsx     15-step assessment wizard
    plan.tsx           Weekly plan
    math.tsx           Math weekly
    children.tsx       Add/edit/delete children
    practice/[subject].tsx  Question practice engine
  (kid)/
    _layout.tsx        Kid tab navigator (simplified)
    index.tsx          Kid dashboard
    story.tsx          Kid story reader
    practice/[subject].tsx  Kid practice (large text, emoji feedback)
  (admin)/
    _layout.tsx        Admin tab navigator
    index.tsx          Admin dashboard + stats
    users.tsx          User management + role assignment
    config.tsx         App config CMS
    content/
      worksheets.tsx   Worksheet CRUD
      stories.tsx      Story CRUD
      wisdom.tsx       Wisdom CRUD
      questions.tsx    Question template editor

api/            Axios wrappers for every backend endpoint
components/
  ui/           Shared design system (Button, Card, Input, Badge, ScreenHeader, EmptyState)
  WisdomCard    Daily wisdom card with track theming
  SubjectCard   Subject grid tile
  StreakBadge   Streak + weekly minutes display
  QuestionCard  MCQ + fill-blank question with submit/feedback
constants/
  theme.ts      Colors, subject metadata, cultural tracks, grades
hooks/
  useApi.ts     React Query hooks for all data
  useConfig.ts  App config with 5-min cache
  useChildren.ts Children list + add/delete mutations
store/
  authStore.ts  Zustand: token, role, family, kidId — persisted to SecureStore
  childStore.ts Zustand: children list + activeChild
```

## Role routing

| Role   | Landing → | Token lifetime |
|--------|-----------|----------------|
| parent | /(parent) | 30 days        |
| admin  | /(admin)  | 30 days        |
| kid    | /(kid)    | 8 hours        |

## Environment variables

| Variable               | Description                        |
|------------------------|------------------------------------|
| EXPO_PUBLIC_API_URL    | Backend base URL (no trailing /)   |
