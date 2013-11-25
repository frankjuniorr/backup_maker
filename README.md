backup_maker
============

## Descrição
O backup_maker, nada mais é do q um script de backup, feito em Shell Script,
que copia arquivospara um destino de backup.
Contando com ajuda de um lembrete, também feito em shell script para avisar quando
estiver no tempo de fazer outro backup, via email.
Esse script é um wrapper para o comando `rsync`.

## Uso

### Sintaxe:
`./backup_maker <origem> <destino>`

### exemplos:

modo simples. Uma Origem pra um Destino

`./backup_maker ~/Photos /media/hd_externo`

modo composto. Vários diretórios de origens, dentro de um arquivo [orbigatoriamente] chamado de "origens.txt".

OBS: Só pode ter apenas 1 destino

`./backup_maker origens.txt /media/hd_externo`

### Dica:
Se quiser copiar a pasta toda, passe a origem SEM a barra do final, assim:
```
./backup_maker ~/Photos /media/hd_externo

ls /media/hd_externo
Photos
```

Se quiser copiar apenas os arquivos, passe a origem COM a barra do final, assim:
```
./backup_maker ~/Photos/ /media/hd_externo

ls /media/hd_externo
foto1.jpg
foto2.jpg
foto3.jpg
```



## Como contribuir?

é só dá um fork e um pull, pra quem tiver dúvida, aqui tem alguns link de ajuda:

- [Fork, Branch, Track, Squash and Pull Request](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/)
- [Send pull requests](http://help.github.com/send-pull-requests/)

Pra quem precisa de ajuda com git, acesse esses links:
- [Managing Projects with GitHub](http://www.lullabot.com/blog/managing-projects-github)
- [Guia pra quem saca de SVN](https://git.wiki.kernel.org/articles/g/i/t/GitSvnCrashCourse_512d.html)
- [Git Reference](http://gitref.org) — Guia rápido, com exemplos
- [The Git Parable](http://tom.preston-werner.com/2009/05/19/the-git-parable.html) — Entenda a filosofia por trás do git
- [Help GitHub](https://help.github.com/) — A propria página de help do Github é muito boa
