{ mutate, direnv }:
mutate ./zshrc {
  inherit direnv;
}

# { mutate }:
# mutate ./zshrc {}
