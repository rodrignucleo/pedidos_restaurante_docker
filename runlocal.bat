@echo off

start cmd /c "cd ./docker/api/ProjetoGerenciamentoRestaurante.API && dotnet watch run"
start cmd /c "cd ./docker/frontend/ProjetoGerenciamentoRestaurante.RazorPages && dotnet watch run"
