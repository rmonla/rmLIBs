## Markdown --->[Mastering Markdown](https://guides.github.com/features/mastering-markdown)
### Enlace
    [Mastering Markdown](https://guides.github.com/features/mastering-markdown)
## Código
### Normal (4 espacios)
    function fancyAlert(arg) {
      if(arg) {
        $.facebox({div:'#foo'})
      }
    }
### De Lenguaje
```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

## Submódulos
### Clonar --->[6.6. Submódulos](https://uniwebsidad.com/libros/pro-git/capitulo-6/submodulos)
    git submodule add https://github.com/rmonla/dticAulaVirtual.git aulavirtual
    git submodule init
    git submodule update

### Clonar --->[Eliminar un Submódulo](https://metadrop.net/articulos/eliminar-submodulo-git-submodule-deinit)
    git submodule deinit <ruta_submodulo> 
    git rm -r <ruta_submodulo>
    rm -r .git/<ruta_submodulo>
    git commit -m "Mensaje con los cambios realizados"
    git push
