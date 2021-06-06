final String searchCharacter = """
          query searchCharacter(\$character: String) {
              character: Character(search: \$character) {
                id,
                name {
                  full
                  native
                },
                image {
                  large
                }
              }
          }
    """;
