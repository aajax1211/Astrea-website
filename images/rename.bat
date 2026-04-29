@echo off
echo Renaming Astrea image assets...

REM ── Company Logo ──────────────────────────
ren "68277a4d0294088d137ac205_Logo Screenshot 256x256.jpg" "logo.jpg"
ren "682779c8840383be6882c8a4_Logo Screenshot 32x32.png" "favicon.png"

REM ── Tool Logos ────────────────────────────
ren "680fea8b2b2016529e7c5533_Relativity Logo.png" "logo-relativity.png"
ren "680feb14af2f07a1dc226e69_Reveal Logo.png" "logo-reveal.png"
ren "680fe99fee4e62f0b155e16e_Logikcull Logo.png" "logo-logikcull.png"

REM ── Icons ─────────────────────────────────
ren "680ff54cb15ccbe49be646b5_ChatGPT Image Apr 28, 2025, 05_38_09 PM.png" "icon-search.png"
ren "680ff4ccf95b2b1408e326c0_Identifcation Image.png" "icon-identify.png"
ren "680ff5b408e1ac4b6414cb02_ChatGPT Image Apr 28, 2025, 05_40_02 PM.png" "icon-cloud.png"
ren "680ff6f2bf5e9eb2a2cfe13b_ChatGPT Image Apr 28, 2025, 05_45_19 PM.png" "icon-processing.png"
ren "680ff7f1cfb83c589109c649_ChatGPT Image Apr 28, 2025, 05_49_34 PM.png" "icon-checklist.png"
ren "680ff8ea66dec204b9d03df0_ChatGPT Image Apr 28, 2025, 05_53_42 PM.png" "icon-security.png"
ren "680ff864b28596c5daa4b421_ChatGPT Image Apr 28, 2025, 05_51_16 PM.png" "icon-document.png"
ren "680ff93b83fee27f198dd9c5_ChatGPT Image Apr 28, 2025, 05_55_03 PM.png" "icon-analytics.png"
ren "680ff98378739921d853921a_ChatGPT Image Apr 28, 2025, 05_56_09 PM.png" "icon-review.png"
ren "680ffd53fcd8e928cb0c9400_ChatGPT Image Apr 28, 2025, 06_12_30 PM.png" "icon-trophy.png"

echo.
echo Done! All files renamed successfully.
echo Now rename the "Images" folder itself to "images" (lowercase).
pause
