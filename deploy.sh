#!/bin/sh
# Deploy to Cloudflare Pages. Stages a clean copy so repo-internal files
# (.git, CLAUDE.md, this script) never reach the public host.
#
#   ./deploy.sh              -> production (getfullbleed.com)
#   ./deploy.sh --preview    -> throwaway *.pages.dev URL, production untouched
set -eu
cd "$(dirname "$0")"

case "${1:-}" in
  --preview) TARGET="--branch preview" ;;
  '')        TARGET='' ;;
  *)         echo "usage: $0 [--preview]" >&2; exit 2 ;;
esac
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
rsync -a --exclude '.git' --exclude 'CLAUDE.md' --exclude '.gitignore' \
  --exclude 'deploy.sh' --exclude '.wrangler' ./ "$STAGE/"
# TARGET is intentionally unquoted: it is either empty or two separate args.
# shellcheck disable=SC2086
npx -y wrangler@4.118.0 pages deploy "$STAGE" --project-name gta-al-minuto \
  --commit-dirty=true $TARGET
