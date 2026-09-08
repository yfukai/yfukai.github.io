# Yohsuke T. Fukai's personal website

This website was generated using [al-folio](https://github.com/alshedivat/al-folio).

See [documentation](https://github.com/alshedivat/al-folio/blob/main/INSTALL.md) for deployment details.

Note: installed prettier pre-commit hook by `npx mrm@2 lint-staged`.

## Running the site locally

The site is served out of the prebuilt al-folio Docker image. A container
runtime is required — on macOS, [Colima](https://github.com/abiosoft/colima)
works well:

```bash
colima start
```

### Live preview

```bash
docker compose up
```

The site is then at <http://localhost:8080>, with live reload on port 35729.
The first run takes a few minutes while `bundle install` populates
`Gemfile.lock`; later runs start in seconds. Stop it with `docker compose down`.

Edits to pages, posts, `_news/`, `_data/` and `assets/json/resume.json` are
picked up automatically — jekyll runs with `--force_polling`, since inotify
events do not cross a bind mount on macOS. Edits to `_config.yml` are **not**
picked up; restart the container after changing it:

```bash
docker compose restart
```

### Building the static site

To produce `_site/` without serving it:

```bash
docker run --rm -v "$PWD":/srv/jekyll -w /srv/jekyll \
  --entrypoint /bin/bash amirpourmand/al-folio:latest \
  -c 'bundle install --jobs 4 --retry 3 && JEKYLL_ENV=production bundle exec jekyll build'
```

`bin/cibuild` does the same thing when Ruby and the gems are available on the
host directly.

Deployment to GitHub Pages is handled by the workflow in `.github/workflows/`;
pushing to `master` is enough, and the built output is not committed.

## Local notes

Two deviations from the upstream al-folio template, both deliberate:

**`docker-compose.yml` sets `command: ./bin/entry_point.sh`.** The image ships
its own newer `/tmp/entry_point.sh`, which runs `git config` under
`set -euo pipefail`. This repository is checked out as a git submodule, so its
`.git` is a pointer file to a gitdir outside the mounted volume; git exits 128
there and takes the whole entry point down with it. Running the copy in
`bin/entry_point.sh` avoids git entirely.

Do not use `docker-compose-slim.yml`. The published `amirpourmand/al-folio:slim`
image was stripped with `mintoolkit`, which deleted `/tmp/entry_point.sh` while
leaving the image's `CMD` pointing at it, and it ships amd64 only. The `:latest`
tag is arm64-native and intact.

**The `Gemfile` declares `ostruct`, `csv`, `base64`, `logger` and several other
libraries that used to ship with Ruby.** They were unbundled from the standard
library in Ruby 3.4/4.0, but jekyll plugins still `require` them —
`jekyll-twitter-plugin` needs `ostruct`. Without those lines, `bundle exec
jekyll` fails on newer rubies with `cannot load such file -- ostruct`. Keep them.
