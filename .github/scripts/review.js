const { GoogleGenAI } = require('@google/genai');
const { execSync } = require('child_process');

async function main() {
  const diff = execSync(
    'git diff ' + process.env.BASE_SHA + '...' + process.env.HEAD_SHA + " -- '*.ts' '*.tsx'",
    { maxBuffer: 1024 * 1024 * 10 }
  ).toString();

  if (!diff.trim()) {
    console.log('No changes');
    return;
  }

  const truncatedDiff = diff.length > 300000 ? diff.slice(0, 300000) + '\n\n[大きな差分を省略]' : diff;
  const ai= new GoogleGenAI();
  const res = await ai.models.generateContent({
    model: 'gemini-3.1-flash-lite',
    contents: '以下のPR差分をレビュー:\n\n' + truncatedDiff,
    config: {
      systemInstruction: 'あなたはシニアエンジニア。PRのdiffをreviewして、バグ・セキュリティリスク・可読性・拡張性の観点でフィードバックしてください。日本語で箇条書きで簡潔に。自分の知識が古い可能性を十分考慮して。',
      maxOutputTokens: 2048,
    }
  });

  const review = res.text;

  await fetch('https://api.github.com/repos/' + process.env.GITHUB_REPOSITORY + '/issues/' + process.env.PR_NUMBER + '/comments', {
    method: 'POST',
    headers: {
      'Authorization': 'Bearer ' + process.env.GITHUB_TOKEN,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      body: '## 🤖 Gemini Code Review\n\n' + review + '\n\n---\n*powered by Gemini API*'
    })
  });

  console.log('Done');
}

main().catch(console.error);
