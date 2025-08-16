# Repository Guidelines

## Project Structure & Module Organization

- `lib/` — Ruby source. Entry is `lib/text_extractor.rb`; handlers live under `lib/text_extractor/file_handler/` (e.g., `plaintext_handler.rb`, `external_command_handler/*.rb`, `zipped_xml_handler/**/*.rb`).
- `spec/` — RSpec tests. Place unit specs under `spec/lib/...`; test data under `spec/fixtures/files/`.
- `bin/` — Dev helpers (`bin/setup`, `bin/console`).
- Root files — `Gemfile`, `Rakefile`, `.rspec`, `text_extractor.gemspec`, `README.md`.

## Build, Test, and Development Commands

- `bundle install` — Install gem + dev dependencies.
- `bundle exec rspec` or `rake` — Run tests (default task is `:spec`).
- `bin/console` — Open an IRB console with the gem loaded.
- Example usage in a console:
  ```ruby
  file = File.new('spec/fixtures/files/text.txt','r')
  TextExtractor::Resolver.new(file, 'text/plain').text
  ```

## Coding Style & Naming Conventions

- Ruby, 2‑space indentation; freeze string literals where practical.
- Use snake_case file names and CamelCase classes/modules under the `TextExtractor` namespace.
- Organize new extractors by type:
  - XML-based formats: subclass `ZippedXmlHandler` under `zipped_xml_handler/`.
  - External tools: subclass `ExternalCommandHandler` under `external_command_handler/`.
  - Plain text/CSV: prefer `PlaintextHandler` patterns.

## Testing Guidelines

- Framework: RSpec. Place specs under `spec/lib/...`, name files `*_spec.rb`.
- Use fixture files in `spec/fixtures/files/` to cover common formats.
- Example spec pattern: resolve by `content_type` and assert extracted text.
- Aim to test both handler selection (`Resolver`) and extracted content for representative files.

## Commit & Pull Request Guidelines

- Commit style: short, imperative subject (e.g., `add json to plain text handler`).
- PRs should include: concise description, rationale, test coverage, and notes on new external tool requirements.
- Link related issues and include before/after behavior when relevant.

## Security & Configuration Tips

- External CLI tools are invoked for some formats (e.g., `pdftotext`, `unrtf`, `tesseract`, `xls2csv`, `catdoc`, `catppt`). Ensure paths via `config/text_extractor.yml` (Rails) or override `TextExtractor::Configuration.load` (plain Ruby). See `text-extractor.yml.example`.
- Prefer streaming/IO-safe usage and avoid loading untrusted files into memory unnecessarily.
