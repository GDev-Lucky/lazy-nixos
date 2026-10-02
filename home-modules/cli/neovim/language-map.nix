{ pkgs, ... }:

{
# Systems / low-level

	nix = {
		grammars = [ "nix" ];

		servers.nixd = {
			package = pkgs.nixd;

			settings = {
				nixd = {
					options = {
						nixos.expr =
							"(builtins.getFlake \"/etc/nixos\").nixosConfigurations.nixos.options";

						home-manager.expr =
							"(builtins.getFlake \"/etc/nixos\").nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []";					};
				};
			};
		};
	};

	c = {
		grammars = [ "c" ];
		servers.clangd.package = pkgs.llvmPackages.clang-tools;
	};

	cpp = {
		grammars = [ "cpp" ];
		servers.clangd.package = pkgs.llvmPackages.clang-tools;
	};

	objective-c = {
		grammars = [ "objc" ];
		servers.clangd.package = pkgs.llvmPackages.clang-tools;
	};

	rust = {
		grammars = [ "rust" ];
		servers.rust_analyzer.package = pkgs.rust-analyzer;
	};

	zig = {
		grammars = [ "zig" ];
		servers.zls = { };
	};

	asm = {
		grammars = [ "asm" ];
		servers.asm_lsp = { };
	};

	fortran = {
		grammars = [ "fortran" ];
		servers.fortls = { };
	};

# Shell / scripting

	bash = {
		grammars = [ "bash" ];
		servers.bashls = { };
	};

	fish = {
		grammars = [ "fish" ];
		servers.fish_lsp = { };
	};

	powershell = {
		grammars = [ "powershell" ];
		servers.powershell_es = { };
	};

	lua = {
		grammars = [ "lua" ];
		servers.lua_ls = { };
	};

	python = {
		grammars = [ "python" ];
		servers.basedpyright = { };
	};

	ruby = {
		grammars = [ "ruby" ];
		servers.solargraph = { };
	};

	php = {
		grammars = [ "php" ];
		servers.phpactor = { };
	};

	perl = {
		grammars = [ "perl" ];
		servers.perlnavigator = { };
	};

# Web

	javascript = {
		grammars = [ "javascript" ];
		servers.ts_ls = { };
	};

	typescript = {
		grammars = [ "typescript" ];
		servers.ts_ls = { };
	};

	tsx = {
		grammars = [ "tsx" ];
		servers.ts_ls = { };
	};

	deno = {
		grammars = [ "javascript" "typescript" "tsx" ];
		servers.denols = { };
	};

	html = {
		grammars = [ "html" ];
		servers.html = { };
	};

	css = {
		grammars = [ "css" ];
		servers.cssls = { };
	};

	scss = {
		grammars = [ "scss" ];
		servers.cssls = { };
	};

	vue = {
		grammars = [ "vue" ];
		servers.volar = { };
	};

	svelte = {
		grammars = [ "svelte" ];
		servers.svelte = { };
	};

	astro = {
		grammars = [ "astro" ];
		servers.astro = { };
	};

	graphql = {
		grammars = [ "graphql" ];
		servers.graphql = { };
	};

# JVM / CLR

	java = {
		grammars = [ "java" ];
		servers.jdtls = { };
	};

	kotlin = {
		grammars = [ "kotlin" ];
		servers.kotlin_language_server = { };
	};

	scala = {
		grammars = [ "scala" ];
		servers.metals = { };
	};

	csharp = {
		grammars = [ "c_sharp" ];
		servers.omnisharp = { };
	};

	fsharp = {
		grammars = [ "fsharp" ];
		servers.fsautocomplete = { };
	};

# Functional

	haskell = {
		grammars = [ "haskell" ];
		servers.hls = { };
	};

	ocaml = {
		grammars = [ "ocaml" "ocaml_interface" ];
		servers.ocamllsp = { };
	};

	elixir = {
		grammars = [ "elixir" "heex" ];
		servers.elixirls = { };
	};

	erlang = {
		grammars = [ "erlang" ];
		servers.erlangls = { };
	};

	clojure = {
		grammars = [ "clojure" ];
		servers.clojure_lsp = { };
	};

	gleam = {
		grammars = [ "gleam" ];
		servers.gleam = { };
	};

# Mobile / UI

	dart = {
		grammars = [ "dart" ];
		servers.dartls = { };
	};

	qml = {
		grammars = [ "qmljs" ];
		servers.qmlls = { };
	};

	swift = {
		grammars = [ "swift" ];
		servers.sourcekit = { };
	};

# Data / configuration

	json = {
		grammars = [ "json" ];
		servers.jsonls = { };
	};

	jsonc = {
		grammars = [ "jsonc" ];
		servers.jsonls = { };
	};

	yaml = {
		grammars = [ "yaml" ];
		servers.yamlls = { };
	};

	toml = {
		grammars = [ "toml" ];
		servers.taplo = { };
	};

	xml = {
		grammars = [ "xml" ];
		servers.lemminx = { };
	};

	sql = {
		grammars = [ "sql" ];
		servers.sqls = { };
	};

	prisma = {
		grammars = [ "prisma" ];
		servers.prismals = { };
	};

	protobuf = {
		grammars = [ "proto" ];
		servers.buf_ls = { };
	};

# Infrastructure / DevOps

	dockerfile = {
		grammars = [ "dockerfile" ];
		servers.dockerls = { };
	};

	terraform = {
		grammars = [ "hcl" "terraform" ];
		servers.terraformls = { };
	};

	ansible = {
		grammars = [ "yaml" ];
		servers.ansiblels = { };
	};

	helm = {
		grammars = [ "helm" ];
		servers.helm_ls = { };
	};

# Build systems

	cmake = {
		grammars = [ "cmake" ];
		servers.cmake = { };
	};

	meson = {
		grammars = [ "meson" ];
		servers.mesonlsp = { };
	};

	make = {
		grammars = [ "make" ];
		servers = { };
	};

# General / cloud

	go = {
		grammars = [ "go" "gomod" "gosum" "gowork" ];
		servers.gopls = { };
	};

# Scientific

	r = {
		grammars = [ "r" ];
		servers.r_language_server = { };
	};

	julia = {
		grammars = [ "julia" ];
		servers.julials = { };
	};

# Documentation

	markdown = {
		grammars = [ "markdown" "markdown_inline" ];
		servers.marksman = { };
	};

	latex = {
		grammars = [ "latex" "bibtex" ];
		servers.texlab = { };
	};

	typst = {
		grammars = [ "typst" ];
		servers.tinymist = { };
	};

# Editor / misc

	vim = {
		grammars = [ "vim" "vimdoc" ];
		servers.vimls = { };
	};

	ada = {
		grammars = [ "ada" ];
		servers.ada_ls = { };
	};
}
