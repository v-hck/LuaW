# LuaW — Agent Guide

## Project Overview

LuaW is a Luau framework designed to run inside Roblox exploit executors that expose the UNC (Universal Naming Convention) API. It wraps native Luau/Roblox values (strings, numbers, functions, tables, Instances) in a custom object type called `luaw` and provides overloaded operators, custom methods, and a unified API layer.

The project is in an early, experimental state. The core framework lives in a single file, there is no package manager or build pipeline, and the test file is currently non-functional.

- **Language:** Luau
- **Target runtime:** Roblox client with a UNC-compatible executor
- **License:** GNU General Public License v3.0 (`LICENSE`)
- **Repository origin:** `git@github.com:v-hck/LuaW.git`

## Repository Layout

```
LuaW/
├── main.luau              # Core framework (771 lines). Defines the luaw type system,
│                          # kernel/normal functions, Roblox service shortcuts, and metatable operators.
├── loader.luau            # Bootstrap loader. Downloads `main.luau` from GitHub and caches it locally.
├── unc_fixer.luau         # Compatibility shim: checks for required UNC functions and provides
│                          # replaceable polyfills where possible.
├── luaw.d.luau            # Luau type definitions (~16K lines). Exports types like `luaw`, `str`,
│                          # `int`, `lts`, `ins`, `gins`, `bin`, plus full Roblox enum/class declarations.
├── luaw.D.json            # JSON mirror of the type/definition data (~145K lines). Likely consumed
│                          # by tooling or executor intellisense.
├── tests/
│   └── all.luau           # Test entry point. Currently only contains `loadstring("services")`,
│                          # which is not valid and will fail at runtime.
├── plan/                  # Obsidian vault used for design notes and task tracking.
│   ├── tracker.md         # DataviewJS dashboard for task progress inside Obsidian.
│   └── classes/           # Planning templates for class/metamorphosis design.
├── .obsidian/             # Obsidian workspace configuration.
├── .trash/                # Deleted Obsidian notes.
├── .gitignore             # Excludes `.obsidian/` and `.trash/`.
└── LICENSE                # GPL v3.0
```

## Technology Stack and Runtime Architecture

### Runtime

- **Luau** is the implementation language.
- The code is annotated with `--!strict` and `--!optimize 2` at the top of `main.luau`.
- The framework expects a Roblox executor environment with UNC functions such as `cloneref`, `gethui`, `readfile`, `writefile`, `isfile`, `loadstring`, `game:HttpGet`, etc.
- `unc_fixer.luau` validates the presence of required UNC functions and injects fallbacks for some of them (e.g., `cloneref`, `gethui`, `setfpscap`). If any non-replaceable function is missing, it throws an error.

### Core Architecture (`main.luau`)

The framework is built around a single global table `getgenv().__luaw__` with these subsystems:

- `__luaw__.type_system`
  - `raw` — registration tables for default properties (`default_props`), function-wrapped properties (`func_props`), wrap modifiers (`wraps_mods`), methods (`methods`), and operators (`operators`). These are organized per wrapped type.
  - `compiled` — runtime-generated metatables (`meta`) and wrapper tables (`wraps`) produced by `k.mk` / `k.make`.
  - `help` — helper iterators and cache-request tables used during wrapper construction.
- `__luaw__.funcs`
  - `kernel` — low-level core functions (e.g., `k.l` to wrap values, `k.ul` to unwrap, `k.mk` to build the type system).
  - `normal` — user-facing utilities (e.g., `n.qw` quick wait, `n.chat`, `n.bypass_chat`).
  - `backups` — saved references to original globals/functions.
  - `orig` — set of original functions used to detect method-call semantics.
- `__luaw__.objects`
  - `roblox` — cached Roblox services and common objects (`Workspace`, `Players`, `RunService`, `LocalPlayer`, camera, mouse, etc.).
  - `luaw` — reserved for future framework-specific objects.
- `__luaw__.config`
  - `log` and `warn` toggles that control whether metatable operations are instrumented with counters.

### Wrapped Types

LuaW can wrap: `string`, `number`, `function`, `table`, `Instance`, `Vector3`, `CFrame`, plus a pseudo-type `GInstance` (a group/list of Instances). Each wrapper is a table with:

- `_self` — the underlying native value.
- `_type` — the wrapped type name.
- `_cache` — per-object cache table.
- `_iter_lt` — iterator state.
- `_created`, `_last_interaction`, `_age` — lifecycle metadata.
- Optional operation counters when `cfg.log == true`.

Custom metamethods (`__index`, `__newindex`, `__call`, `__add`, `__sub`, `__mul`, `__div`, `__idiv`, `__mod`, `__pow`, `__unm`, `__eq`, `__lt`, `__le`, `__concat`, `__len`, `__iter`) are attached based on the type.

### Notable Operators

- **String:** `-str` reverses; `str - pattern` removes matches; `str * n` repeats; `str / pattern` counts matches.
- **Table:** `+`, `-`, `*`, `^`, `/`, `//`, `%` perform table concatenation, removal, repetition, and counting.
- **Instance:** call syntax (`ins(n, condition)`) collects descendants; `+` parents an Instance; `-` destroys matching children; `*` clones; `/` unparents matching children; `//` unparents children one level; `%` collects children.
- **Function:** call through a luaw function is cached by argument hash when caching is enabled; `-func` wraps in `pcall`.

## Build and Test Commands

There is **no build system** in this repository. There are no `package.json`, `Cargo.toml`, `pyproject.toml`, Makefile, or similar configuration files.

### Running the Framework

1. **Direct load via loader (executor):**
   ```luau
   loadstring("https://raw.githubusercontent.com/fgdergewrgegr/LuaW/refs/heads/main/loader.luau")()
   ```
   The loader:
   - Runs `unc_fixer.luau` to validate the environment.
   - Tries to read and execute `LuaW/main.luau` from the local file system.
   - If local execution fails, fetches `main.luau` from the repository raw URL and writes it to `LuaW/main.luau`.

2. **Direct load of `main.luau`:**
   ```luau
   loadstring(readfile("LuaW/main.luau"))()
   ```

### Testing

The only test file is `tests/all.luau`, and it currently contains a single invalid line:

```luau
loadstring("services")
```

This will error because `"services"` is not valid Luau bytecode. There is no working test harness or test runner at the moment.

## Code Style Guidelines

- Use `--!strict` and `--!optimize 2` for top-level framework files.
- Prefer explicit Luau type annotations; the project is heavily typed.
- Naming conventions observed in `main.luau`:
  - Short aliases for frequently used tables/functions: `k` = kernel, `n` = normal, `b` = backups, `ro` = Roblox objects, `ts` = type system, etc.
  - Wrapper types: `str`, `int`, `lts`, `ins`, `gins`, `bin`.
  - Metamethod variables: `op_*` for operators, `m_*` for methods, `wm_*` for wrap modifiers, `fp_*` for function properties.
- Keep kernel/core functions separate from user-facing "normal" functions; the codebase already separates them and there is an explicit TODO to split the API further for safety.
- When adding a new wrapped type, register it in `atp`/`atp_lt`, provide `default_props`, `operators`, and optionally `methods`, `func_props`, and `wraps_mods`, then call `k.mk` to rebuild compiled tables.

## Development Workflow

- The `plan/` directory is an Obsidian vault. It contains markdown notes and DataviewJS dashboards for tracking features. It is excluded from Git by `.gitignore`.
- Commit messages in the history are often short or placeholders (e.g., `t`, `int`, `str`, `plan`, `fixxx`). Do not rely on them for detailed change descriptions; read the diff.
- There are two active branches in the remote: `main` and `plan`.

## Security Considerations

- The framework relies on `loadstring` to execute remote code from GitHub. Treat the repository as a trusted source; any compromise of the remote `main.luau` or `loader.luau` propagates directly to users.
- `unc_fixer.luau` injects functions into the global environment (`getgenv()`) to satisfy UNC requirements. This can mask missing capabilities and may affect executor behavior.
- The framework caches downloaded code to the local executor file system (`LuaW/main.luau`). Verify the cached copy when debugging.
- Several core functions bypass normal Roblox/Luau boundaries (e.g., `crypt.hash`, `Instance.fromExisting`, `cloneref`). Changes to these calls can trigger anti-cheat or detection systems in live games.
- Be cautious with the Instance destruction and parent-manipulation operators (`-`, `/`, `//`, `*`, `^`, `%`) — they operate on live game objects and can remove or clone instances unexpectedly.

## Known Issues and TODOs

A non-exhaustive list from `main.luau` comments:

- Random text generation is commented out and marked `FIX`/`TODO` in multiple places.
- The kernel/normal API split is incomplete (`TODO: need to make split api to kernel and custom for safe framework funcs if user wants remake core funcs`).
- `k.lst` (`__totable`) has a TODO to replace `its[tp]` with `:__totable()`.
- String fast-load for `str:run()` is not implemented.
- `str.__add` needs a design decision.
- Several Instance operators are incomplete or need cache integration (`__len`, `__iter`).
- Vector3 and CFrame wrappers are declared in the type system but their operators are not fully implemented in `main.luau`.

## External Dependencies

No external package manager dependencies. The only dependencies are the Roblox engine APIs and the UNC executor functions listed in `unc_fixer.luau`:

Required: `cloneref`, `gethui`, `readfile`, `writefile`, `appendfile`, `delfile`, `makefolder`, `isfile`, `isfolder`, `listfiles`, `dofile`, `rconsoleprint`, `rconsolesettitle`, `rconsoleinput`, `rconsoleclear`, `setclipboard`, `setfpscap`, `lz4compress`, `lz4decompress`.

Replaceable polyfills exist for: `cloneref`, `gethui`, `dofile`, `setfpscap`, `setclipboard`, `rconsoleprint`, `rconsolesettitle`, `rconsoleinput`, `rconsoleclear`.
