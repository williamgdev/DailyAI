#!/bin/bash
# Scans the entire skills/ folder and links every skills/<name>/ that has a SKILL.md
# into .cursor/skills/, .claude/skills/, .codex/skills/, .vscode/skills/ so Cursor, Claude, Codex, VS Code auto-discover them.
# Run from repo root. Idempotent. Use --copy to copy instead of symlinking.
# Add a new skill as skills/<name>/SKILL.md (and optional scripts); re-run this script to link it.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILLS_SRC="${REPO_DIR}/skills"
USE_COPY=false

# Optional: only link these skill names (e.g. setup-skill-clients.sh obsidian-workflow)
# Optional: --clients cursor,claude,codex,vscode to link only to those (default: all)
# With no skill names: link all. --copy still copies instead of symlinking.
SKILL_FILTER=()
CLIENT_FILTER=()
while [ $# -gt 0 ]; do
  case "$1" in
    --copy) USE_COPY=true; shift ;;
    --clients)
      shift
      [ $# -gt 0 ] || { echo "Missing value for --clients"; exit 1; }
      IFS=',' read -ra CLIENT_FILTER <<< "$1"
      shift
      ;;
    -h|--help)
      echo "Usage: $0 [--copy] [--clients cursor,claude,codex,vscode] [skill1 [skill2 ...]]"
      echo "  Links (or with --copy, copies) skills from skills/ into project client dirs:"
      echo "  - cursor  -> .cursor/skills/"
      echo "  - claude  -> .claude/skills/"
      echo "  - codex   -> .codex/skills/"
      echo "  - vscode  -> .vscode/skills/"
      echo "  Scans skills/ for every folder with SKILL.md. No names = link all; with names = link only those."
      echo "  With no --clients: use all clients. With --clients: only those (comma-separated)."
      echo "  Run from repo root. Idempotent."
      exit 0
      ;;
    *) SKILL_FILTER+=("$1"); shift ;;
  esac
done

# Client id -> directory (relative to REPO_DIR)
client_cursor_dir=".cursor/skills"
client_claude_dir=".claude/skills"
client_codex_dir=".codex/skills"
client_vscode_dir=".vscode/skills"

client_enabled() {
  local c="$1"
  [ ${#CLIENT_FILTER[@]} -eq 0 ] && return 0
  for e in "${CLIENT_FILTER[@]}"; do
    [ "$e" = "$c" ] && return 0
  done
  return 1
}

SKILL_NAMES=()
if [ -d "$SKILLS_SRC" ]; then
  for dir in "$SKILLS_SRC"/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    if [ -f "${dir}SKILL.md" ]; then
      if [ ${#SKILL_FILTER[@]} -eq 0 ]; then
        SKILL_NAMES+=("$name")
      else
        for want in "${SKILL_FILTER[@]}"; do
          if [ "$want" = "$name" ]; then
            SKILL_NAMES+=("$name")
            break
          fi
        done
      fi
    fi
  done
fi

if [ ${#SKILL_NAMES[@]} -eq 0 ]; then
  if [ ${#SKILL_FILTER[@]} -gt 0 ]; then
    echo "No matching skills found. Available: $(ls -1 "$SKILLS_SRC" 2>/dev/null | tr '\n' ' ')"
  else
    echo "No skills found under ${SKILLS_SRC} (expected skills/<name>/SKILL.md)."
  fi
  exit 0
fi

CLIENT_LIST=""
[ ${#CLIENT_FILTER[@]} -eq 0 ] && CLIENT_LIST="Cursor, Claude, Codex, VS Code" || CLIENT_LIST=$(IFS=,; echo "${CLIENT_FILTER[*]}")
echo "Skills found in skills/: ${SKILL_NAMES[*]}"
echo "Linking to: ${CLIENT_LIST}..."
echo ""

for name in "${SKILL_NAMES[@]}"; do
  src="${SKILLS_SRC}/${name}"

  if client_enabled "cursor"; then
    client_dir="${REPO_DIR}/${client_cursor_dir}"
    link_path="${client_dir}/${name}"
    mkdir -p "$client_dir"
    if [ -L "$link_path" ]; then rm -f "$link_path"; fi
    if [ -e "$link_path" ]; then
      echo "  Skip .cursor/skills/${name} (already exists and is not a symlink)"
    elif [ "$USE_COPY" = true ]; then
      cp -R "$src" "$link_path"
      echo "  Copied ${name} -> .cursor/skills/"
    else
      ln -sf "../../skills/${name}" "$link_path"
      echo "  Linked ${name} -> .cursor/skills/"
    fi
  fi

  if client_enabled "claude"; then
    client_dir="${REPO_DIR}/${client_claude_dir}"
    link_path="${client_dir}/${name}"
    mkdir -p "$client_dir"
    if [ -L "$link_path" ]; then rm -f "$link_path"; fi
    if [ -e "$link_path" ]; then
      echo "  Skip .claude/skills/${name} (already exists and is not a symlink)"
    elif [ "$USE_COPY" = true ]; then
      cp -R "$src" "$link_path"
      echo "  Copied ${name} -> .claude/skills/"
    else
      ln -sf "../../skills/${name}" "$link_path"
      echo "  Linked ${name} -> .claude/skills/"
    fi
  fi

  if client_enabled "codex"; then
    client_dir="${REPO_DIR}/${client_codex_dir}"
    link_path="${client_dir}/${name}"
    mkdir -p "$client_dir"
    if [ -L "$link_path" ]; then rm -f "$link_path"; fi
    if [ -e "$link_path" ]; then
      echo "  Skip .codex/skills/${name} (already exists and is not a symlink)"
    elif [ "$USE_COPY" = true ]; then
      cp -R "$src" "$link_path"
      echo "  Copied ${name} -> .codex/skills/"
    else
      ln -sf "../../skills/${name}" "$link_path"
      echo "  Linked ${name} -> .codex/skills/"
    fi
  fi

  if client_enabled "vscode"; then
    client_dir="${REPO_DIR}/${client_vscode_dir}"
    link_path="${client_dir}/${name}"
    mkdir -p "$client_dir"
    if [ -L "$link_path" ]; then rm -f "$link_path"; fi
    if [ -e "$link_path" ]; then
      echo "  Skip .vscode/skills/${name} (already exists and is not a symlink)"
    elif [ "$USE_COPY" = true ]; then
      cp -R "$src" "$link_path"
      echo "  Copied ${name} -> .vscode/skills/"
    else
      ln -sf "../../skills/${name}" "$link_path"
      echo "  Linked ${name} -> .vscode/skills/"
    fi
  fi

done

echo ""
echo "Done. Re-run this script after adding a new skill under skills/."
