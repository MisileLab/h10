# AGENTS

This file documents repo-specific commands and conventions for agentic coding.
It is derived from the current repository contents and observed patterns.
If a rule is missing, prefer the existing patterns in Formula/*.rb.

## Repository overview
- This repository is a Homebrew tap containing Ruby formulae.
- Formula files live under Formula/ and use the Homebrew Formula DSL.
- README.md is minimal and does not define commands.

## Key paths
- Formula/nu-scripts.rb
- Formula/packwiz.rb
- .github/FUNDING.yml (sponsorship metadata)
- renovate.json (Renovate configuration)

## Cursor and Copilot rules
- .cursorrules: not present
- .cursor/rules/: not present
- .github/copilot-instructions.md: not present
- If rules are added later, update this file accordingly.

## Build, lint, and test commands
- No repo-level build/lint/test commands or CI workflows were found.
- Build logic is embedded in each formula's install method.
- Test logic is embedded in each formula's test do block.

### Formula build steps (from source)
- NuScripts: install copies files to pkgshare and writes an autoload script.
- Packwiz: install runs Go build via system "go", "build", *std_go_args.

### Running tests (single formula)
- Tests are Homebrew formula tests, not a separate test suite.
- Use the standard Homebrew command once the tap is installed:
  - brew test <formula>
- Formula names correspond to file names: nu-scripts, packwiz.
- Each test do block is minimal (file existence or --help invocation).
- No separate lint command is defined in this repo.

## Code style and conventions
### Ruby / Formula DSL
- Class names are CamelCase and inherit from Formula.
- File names are kebab-case matching the formula name.
- Use 2-space indentation consistently.
- Method names and variables use snake_case.
- Prefer the standard metadata order as observed:
  - desc, homepage, url, sha256, license, version, head, depends_on
- Place depends_on before def install.
- Implement def install, optional def caveats, and test do blocks.
- Use system for external commands in install or test.
- Use Pathname helpers for paths (e.g., share/"path").
- Use pkgshare.install for file trees when appropriate.
- Use mkpath before writing into nested directories.
- Use heredocs with <<~EOS for multi-line strings.

### Tests in formulae
- Keep tests short and deterministic.
- Use assert_path_exists when verifying installed files.
- Use system bin/"tool", "--help" for CLI sanity checks.
- Avoid complex or long-running tests in test do blocks.

### Error handling
- The formulae rely on Homebrew's default error handling.
- Do not add empty rescue blocks; fail fast on command errors.
- When embedding scripts in heredocs, keep failure handling explicit.

### Formatting
- Keep line length reasonable; break long strings with heredocs.
- Align blocks with do/end at 2-space indentation.
- Avoid trailing whitespace.
- Keep blank lines between metadata, dependencies, and methods.

### Naming and structure examples
- class NuScripts < Formula
- def install
- def caveats
- test do

## Updating formulae
- Update url and sha256 together for new releases.
- Update version if the formula specifies one.
- Keep head entries if upstream supports a main branch build.
- Keep dependencies minimal and explicit.

## Formula layout template (observed)
- class <Name> < Formula
- desc "..."
- homepage "..."
- url "..."
- sha256 "..."
- version "..." (optional)
- license "..."
- head "..." (optional)
- depends_on "..."
- def install
- end
- def caveats (optional)
- end
- test do
- end
- end

## Homebrew tap usage (standard, not defined here)
- Tap this repository before testing formulae.
- Example commands (replace placeholders):
- brew tap <owner>/<tap>
- brew install <formula>
- brew test <formula>
- brew uninstall <formula>
- These are standard Homebrew commands, not repo scripts.

## Nushell script specifics (nu-scripts formula)
- The autoload script is written to share/nushell/vendor/autoload.
- The script loads aliases and completions from pkgshare.
- The script uses Nushell glob and source commands.
- Keep script text aligned with the <<~EOS indentation.

## Go build specifics (packwiz formula)
- Build uses Go and std_go_args in def install.
- Keep Go build flags minimal (-s -w are used).
- Ensure the resulting binary is named packwiz.

## Repository hygiene
- No automated linting is configured; rely on consistency.
- Keep README.md in sync if repository scope changes.
- Renovate config exists but does not affect code style.

## Agent guidance
- Prefer small, targeted edits to formula files.
- Match the surrounding formatting exactly.
- Do not introduce new dependencies without clear need.
- If you add new formulae, mirror the existing structure.

## What is not present
- No CI workflows in .github/workflows.
- No package manager configs (Gemfile, package.json, etc.).
- No explicit lint configs (rubocop, eslint, etc.).

## Verification checklist (lightweight)
- Read the formula file you are changing.
- Update any checksums and versions together.
- Ensure test do block still passes conceptually.
- If you can run tests locally, use brew test <formula>.

## When uncertain
- Follow patterns in Formula/nu-scripts.rb and Formula/packwiz.rb.
- Avoid speculative changes not grounded in repository behavior.
- Ask for clarification if a change affects Homebrew policy.

## Contact points
- There are no maintainers or contacts listed in this repo.
- Use Git history if you need author context.

## Change log
- This file is generated from repository analysis on 2026-01-02.
