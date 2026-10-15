# dockercraft-casaos

Loja de apps do CasaOS com a suite ArtCraft. As imagens Docker sao construidas
pelo repositorio `berg-maia/dockercraft` e publicadas em `ghcr.io/berg-maia/<nome>-web`.

## Adicionar no CasaOS

App Store -> Add Source -> colar:

    https://github.com/berg-maia/dockercraft-casaos/archive/refs/heads/main.zip

## Portas

| App | Porta |
|---|---|
| PhotoCraft | 8765 |
| VectorCraft | 8766 |
| FilmCraft | 8767 |
| LightCraft | 8768 |
| PdfCraft | 8769 |
| EffectCraft | 8770 |
| DesignCraft | 8771 |
| FigCraft | 8772 |
| WordCraft | 8773 |
| SoundCraft | 8774 |
| DeckCraft | 8775 |
| CADCraft | 8776 |
| GridCraft | 8777 |

## Versoes

O workflow `Atualizar versões da loja` consulta a ultima release de cada projeto
oficial e atualiza `version`, `update_at` e a tag da imagem no compose, mas so depois
que a imagem dessa versao existe no ghcr.io.
