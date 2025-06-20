1. Run `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. Press enter for the prompts
3. Run `eval (ssh-agent -c)` for fish
4. Add the ssh key: `ssh-add ~/.ssh/id_ed25519`
5. Copy the ssh key using `cat ~/.ssh/id_ed25519.pub
6. Add to github (settings -> ssh and gpg keys --> new ssh key)
7. Test the connection with `ssh -T git@github.com`
8. Then, use `git@github.com:username/repository.git` as a template for an ssh link
