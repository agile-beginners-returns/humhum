const mockData = {
  "tests": [
    {
      "questionType": "confirmation", //確認問題1
      "question": "Which SQL statement adds data to a database?",
      "choices": [
        "Delete", //1番目が正解
        "INSERT INTO Table (Column) VALUES (value1, value2);",
        "SELECT * FROM Table;",
        "UPDATE Table SET Column = value WHERE Column = value;"
      ]
    },
    {
      "questionType": "confirmation", //確認問題2 同様に作成
      "question": "Which SQL statement adds data to a database?",
      "choices": [
        "Delete", //1番目が正解
        "INSERT INTO Table (Column) VALUES (value1, value2);",
        "SELECT * FROM Table;",
        "UPDATE Table SET Column = value WHERE Column = value;"
      ]
    },
    {
      "questionType": "translation", //日本語訳問題1
      "question": "Can I open the windows? This room is too hot.",
      "choices": [
        "窓を開けません", //1番目が正解
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        " 窓を開けてもいいですか？この部屋は暑すぎす。"
      ]
    },
    {
      "questionType": "translation", //日本語訳問題2 同様に作成
      "question": "Can I open the windows? This room is too hot.",
      "choices": [
        "窓を開けません", //1番目が正解
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        " 窓を開けてもいいですか？この部屋は暑すぎす。"
      ]
    },
    {
      "questionType": "translation", //日本語訳問題3 同様に作成
      "question": "Can I open the windows? This room is too hot.",
      "choices": [
        "窓を開けません", //1番目が正解
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        " 窓を開けてもいいですか？この部屋は暑すぎす。"
      ]
    },
    {
      "questionType": "translation", //日本語訳問題4 同様に作成
      "question": "Can I open the windows? This room is too hot.",
      "choices": [
        "窓を開けません", //1番目が正解
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        "窓を開けてもいいですか？この部屋は暑すぎす。",
        " 窓を開けてもいいですか？この部屋は暑すぎす。"
      ]
    },
    {
      "questionType": "word", // 単語問題1の例
      "question": "Hot",
      "choices": [
        "暑い", //1番目が正解
        "熱い",
        "厚い",
        "寒い"
      ],
      "otherMeanings": "辛い", // 単語他の意味
      "example": "hot air balloon passenger" // 使用例
    },
    {
      "questionType": "word", //単語問題2 同様に作成
      "question": "Hot",
      "choices": [
        "暑い", //1番目が正解
        "熱い",
        "厚い",
        "寒い"
      ],
      "otherMeanings": "辛い", // 単語他の意味
      "example": "hot air balloon passenger" // 使用例
    },
    {
      "questionType": "word", //単語問題3 同様に作成
      "question": "Hot",
      "choices": [
        "暑い", //1番目が正解
        "熱い",
        "厚い",
        "寒い"
      ],
      "otherMeanings": "辛い", // 単語他の意味
      "example": "hot air balloon passenger" // 使用例
    },
    {
      "questionType": "word", //単語問題4 同様に作成
      "question": "Hot",
      "choices": [
        "暑い", //1番目が正解
        "熱い",
        "厚い",
        "寒い"
      ],
      "otherMeanings": "辛い", // 単語他の意味
      "example": "hot air balloon passenger" // 使用例
    }
  ]
};
