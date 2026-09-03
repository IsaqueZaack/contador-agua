# 💧 Contador de Água

Um aplicativo Flutter desenvolvido para ajudar no acompanhamento da hidratação diária. O usuário pode registrar a quantidade de copos de água consumidos, definir uma meta personalizada e visualizar seu progresso de forma simples e intuitiva.

## ✨ Funcionalidades

- Contador de copos de água consumidos
- Meta diária personalizável
- Indicador visual de progresso
- Exibição do consumo em copos, mililitros e litros
- Botão para adicionar um copo de água
- Botão para remover um copo do registro
- Botão para reiniciar o contador
- Persistência local utilizando Shared Preferences
- Interface desenvolvida com Material Design 3

## 📸 Demonstração

```text
Contador de Água
Beba água, cuide de você! 💙

        5
    de 8 copos
     1250 ml
      1.25 L

[ 💧 Beber água ]

Remover 1    Reiniciar
```

## 🛠️ Tecnologias Utilizadas

- Flutter
- Dart
- Material Design 3
- StatefulWidget
- setState
- Shared Preferences
- Async/Await

## 📂 Estrutura do Projeto

```text
lib/
├── main.dart
├── pages/
│   └── home_page.dart
└── services/
    └── preferences_service.dart
```

## 🚀 Como Executar

```bash
flutter pub get
flutter run
```

## 💧 Persistência dos Dados

O aplicativo utiliza o pacote `shared_preferences` para armazenar localmente:

- Quantidade de copos consumidos (`total_cups`)
- Meta diária (`goal_cups`)

## 📚 Conceitos Praticados

- Flutter
- Dart
- StatefulWidget
- setState
- Shared Preferences
- Future, async e await
- AlertDialog
- Indicadores de progresso

## 🎯 Próximas Melhorias

- Histórico diário de consumo
- Notificações para lembrar de beber água
- Tema escuro
- Estatísticas semanais e mensais

## 📄 Licença

Este projeto foi desenvolvido para fins de estudo e aprendizado em Flutter.

---

⭐ Se este projeto te ajudou, deixe uma estrela no repositório! 💙💧
