<div style="width: 100%; height: 97vh; display: flex; justify-content: center; align-items: center; background-color: #f2f2f5; page-break-after: always;">
    <!-- Outer Container for Center Alignment -->
    <div style="width: 100%; max-width: 600px; display: flex; flex-direction: column; align-items: center;">
        <!-- Main Content Container -->
        <div style="width: 100%; background: #f9f9f9; padding: 40px; border-radius: 12px; border: 1px solid #ccc; box-sizing: border-box;">
            <div style="margin-bottom: 20px; text-align: center;">
                <img src="https://i.imgur.com/GcC2YmG.png" alt="Logo" style="width: 120px; height: auto;">
            </div>
            <h2 style="font-size: 24px; font-weight: 700; margin: 0 0 10px; color: #222; text-align: center;">Exercise Documentation</h2>
            <h2 style="font-size: 18px; font-weight: 500; margin: 0 0 20px; color: #666; text-align: center;">CTF Challenge Writeup</h2>
            <hr style="border: none; border-top: 1px solid #ddd; margin: 20px 0;">
            <div style="margin-top: 10px;">
                <div style="font-size: 16px; color: #444; margin-bottom: 8px;">Name: <strong style="font-weight: 600;">Example Name</strong></div>
                <div style="font-size: 16px; color: #444; margin-bottom: 8px;">Category: <strong style="font-weight: 600;">Example Category</strong></div>
                <div style="font-size: 16px; color: #444; margin-bottom: 8px;">Difficulty: <strong style="font-weight: 600;">Example Difficulty</strong></div>
                <div style="font-size: 16px; color: #444; margin-bottom: 8px;">Target Audience: <strong style="font-weight: 600;">Beginner / Community / Pro</strong></div>
                <div style="font-size: 16px; color: #444; margin-bottom: 8px;">Last Update: <strong style="font-weight: 600;">Example Date</strong></div>
            </div>
            <div style="margin-top: 30px; font-size: 14px; color: #888; text-align: center;">Prepared for: CTF.ae</div>
        </div>
        <!-- Disclaimer Footer -->
        <div style="width: 100%; margin-top: 20px; font-size: 12px; color: #666; text-align: center; padding: 10px 20px; line-height: 1.5;">
            Disclaimer: This document is classified as Internal and is intended solely for authorized personnel. Unauthorized distribution, publication, or misuse of this document, in any form, is strictly prohibited and may result in legal action, including civil or criminal liability, as applicable by law. By accessing this document, you acknowledge and agree to adhere to its confidential nature and accept the responsibility to maintain its integrity and confidentiality.
        </div>
    </div>
</div>

## Learning Outcomes

* Out-of-bounds write
* SQL Injection
* Bypassing WAF with URL encoding
* Etc, etc, etc. Include here what the player is going to learn.

## Mapping

* This section is about mapping the challenge to a global benchmark
* MITRE TTPs for Forensics challenges
* OWASP CWEs for web challenges
* Example: CWE-23 Relative Path Traversal

## Challenge Idea

Write a short description of the challenge idea, what the player is supposed to do, and how the challenge is meant to be solved. Keep it short, a single paragraph but long enough to get a good overview of the challenge idea and complexity.

## Writeup Content

Here is where you will write your writeup. Feel free to include screenshots (upload them to imgur) and code snippets. Make sure to explain clearly the steps the player should take to solve the challenge. It is important you explain as clearly as possible, as this is what CTF.ae will use to validate your challenges and may be used in future workshops.

Images must follow this same exact format.
<div style="margin-top: 10px; margin-bottom: 10px; color: #1a1a1a; text-align:center;">
<img src="https://i.imgur.com/nhNjARb.png" width=100% height=100% style="border:1px solid #ccc; border-radius:5px;">
  <p style="margin-top:10px; margin-bottom:10px; color:#1b1b1b; text-decoration:italic;"><i>(Put here a short description of the image)</i></p>
</div>

Code snippets must be in using the markdown format with proper syntax highlighting, as shown below.

```python
def hello_world():
    print("Hello, World!")
```

If your challenge has a static flag, include the flag here. If the flag is dynamic, you can ignore this part.

## Challenge Flag

<div style="margin-top: 10px; margin-bottom: 10px; padding: 10px 10px; background:linear-gradient(to right, #1A2980, #207EA8); border:1px solid #ccc; border-radius: 5px;">
<span style="font-family: menlo; color: white;">FLAG{FLAG_HERE}</span>
</div>
