from __future__ import annotations

import os
import shutil
import subprocess
import textwrap
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
FRONTPAGE_BUILD_DIR = REPO_ROOT / "build" / "samplegen-frontpage"
PRELIM_BUILD_DIR = REPO_ROOT / "build" / "samplegen-prelim"
CHAPTER_BUILD_DIR = REPO_ROOT / "build" / "samplegen-chapters"
SPECIAL_TEXT_BUILD_DIR = REPO_ROOT / "build" / "samplegen-special-text"
SAMPLE_DIR = REPO_ROOT / "sample"
FRONTPAGE_DIR = SAMPLE_DIR / "frontpage"
PRELIM_DIR = SAMPLE_DIR / "prelim"
CHAPTER_DIR = SAMPLE_DIR / "chapters"
SPECIAL_TEXT_DIR = SAMPLE_DIR / "special-text"

FRONTPAGE_STYLES = [
    "star",
    "flower",
    "circle",
    "bluelight",
    "cushion",
    "embroid",
    "emerald",
    "feminine",
    "goldenblue",
    "greencutton",
    "greenflower",
    "petals",
    "rose",
]

PRELIM_STYLES = [
    "curly",
    "straight",
    "sideblock",
    "useimage",
]

CHAPTER_STYLES = [
    "ornament",
    "margin",
    "band",
]

SPECIAL_TEXT_STYLES = [
    "ornament",
    "framed",
    "minimal",
    "centered",
    "poem",
]

LIGHT_COVER_STYLES = {
    "feminine",
    "petals",
    "rose",
}


def ensure_tool(name: str) -> str:
    tool = shutil.which(name)
    if not tool:
        raise SystemExit(f"Required tool not found on PATH: {name}")
    return tool


def tex_env() -> dict[str, str]:
    env = os.environ.copy()
    texinputs = env.get("TEXINPUTS", "")
    env["TEXINPUTS"] = f"{REPO_ROOT}{os.pathsep}{REPO_ROOT}\\{os.pathsep}{texinputs}"
    return env


def run(cmd: list[str], cwd: Path | None = None) -> None:
    subprocess.run(cmd, cwd=cwd or REPO_ROOT, check=True, env=tex_env())


def write_text(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8", newline="\n")


def clean_build_dir(build_dir: Path) -> None:
    if build_dir.exists():
        shutil.rmtree(build_dir)


def compile_tex(source_path: Path, build_dir: Path) -> Path:
    xelatex = ensure_tool("xelatex")
    build_dir.mkdir(parents=True, exist_ok=True)
    command = [
        xelatex,
        "-interaction=nonstopmode",
        "-halt-on-error",
        f"-output-directory={build_dir}",
        str(source_path),
    ]
    run(command)
    run(command)
    return build_dir / f"{source_path.stem}.pdf"


def pdf_to_png(pdf_path: Path, png_path: Path) -> None:
    pdftoppm = ensure_tool("pdftoppm")
    png_path.parent.mkdir(parents=True, exist_ok=True)
    run(
        [
            pdftoppm,
            "-png",
            "-f",
            "1",
            "-singlefile",
            str(pdf_path),
            str(png_path.with_suffix("")),
        ]
    )


def frontpage_logo(style: str) -> str:
    if style in LIGHT_COVER_STYLES:
        return "assets/images/publisher-black.png"
    return "assets/images/publisher-white.png"


def frontpage_tex(style: str) -> str:
    return textwrap.dedent(
        f"""
        \\documentclass[11pt,fleqn,oneside]{{book}}
        \\usepackage[
          frontpage={style},
          theme=default,
          paper=a5,
          backmatter=false,
          chapternumbering=roman,
          coverstyle=auto,
          runningheader=none,
          toc=false
        ]{{bookish}}

        \\booksetup{{
          title={{Explanation of Laamiyyah}},
          subtitle={{of Shaykhul-Islam Ibn Taymiyyah}},
          subtitleposition={{below}},
          author={{Zayd ibn Hadi Al-Madkhali}},
          authoraddress={{Shaykh Al-Allamah}},
          translator={{Abu Al-Abbas Moosaa Richardson}},
          imprint={{Salafi Press}},
          publisherlogo={{{frontpage_logo(style)}}},
          publishstatus={{published}},
          backtext={{Sample back cover copy.}}
        }}

        \\begin{{document}}
        \\frontmatter
        \\bookmaketitlepage
        \\end{{document}}
        """
    ).strip() + "\n"


def prelim_tex(style: str) -> str:
    image_key = ""
    if style == "useimage":
        image_key = "  frontmatterimage={assets/frontimages/emerald.jpg},\n"
    return textwrap.dedent(
        f"""
        \\documentclass[11pt,fleqn,oneside]{{book}}
        \\usepackage[
          frontpage=star,
          theme=default,
          paper=a5,
          backmatter=false,
          chapternumbering=roman,
          coverstyle=auto,
          runningheader=none,
          toc=false
        ]{{bookish}}

        \\booksetup{{
          title={{Explanation of Laamiyyah}},
          author={{Zayd ibn Hadi Al-Madkhali}},
          imprint={{Salafi Press}},
          publishstatus={{published}}
        }}

        \\customizeprelim{{
          frontmatterstyle={style},
          backmatterstyle=auto,
{image_key}        }}

        \\begin{{document}}
        \\frontmatter
        \\bookfrontmattersection{{Translator's Note}}
        This sample page previews the selected prelim opening style for frontmatter sections.

        \\vspace{{1.2em}}
        \\bookepigraph{{A short note can still include a brief epigraph or attribution.}}{{Sample translator}}
        \\end{{document}}
        """
    ).strip() + "\n"


def chapter_tex(style: str) -> str:
    return textwrap.dedent(
        f"""
        \\documentclass[11pt,fleqn,oneside]{{book}}
        \\usepackage[
          frontpage=star,
          theme=default,
          paper=a5,
          backmatter=false,
          chapternumbering=roman,
          coverstyle=auto,
          runningheader=book,
          toc=false
        ]{{bookish}}

        \\booksetup{{
          title={{Explanation of Laamiyyah}},
          author={{Zayd ibn Hadi Al-Madkhali}},
          imprint={{Salafi Press}},
          publishstatus={{published}}
        }}

        \\customizechapter{{
          chapterstyle={style},
          pagenumberposition=center
        }}

        \\begin{{document}}
        \\mainmatter
        \\chapter{{Chapter Style Preview}}
        This page previews the \\texttt{{{style}}} chapter treatment.

        \\section{{A Short Section}}
        Body copy stays ordinary LaTeX content while the chapter and section
        treatments follow the selected preset.
        \\end{{document}}
        """
    ).strip() + "\n"


def special_text_tex(style: str) -> str:
    config = ""
    body = ""
    if style == "poem":
        body = textwrap.dedent(
            """
            \\begin{poem}
            أَلا كُلُّ شَيءٍ ما خَلا اللَهَ باطِلٌ & وَكُلُّ نَعيمٍ لا مَحالَةَ زائِلُ \\\\
            وَكُلُّ أُناسٍ سَوفَ تَدخُلُ بَينَهُم & دُوَيهِيَّةٌ تَصفَرُّ مِنها الأَنامِلُ
            \\end{poem}
            """
        ).strip()
    else:
        config = textwrap.dedent(
            f"""
            \\customizespecialtext{{
              quranstyle={style},
              hadithstyle=auto,
              atharstyle=auto,
              arabicstyle={style}
            }}
            """
        ).strip()
        body = textwrap.dedent(
            """
            \\begin{quran}
            إِنَّ مَعَ الْعُسْرِ يُسْرًا
            \\begin{translation}Indeed, with hardship comes ease.\\end{translation}
            \\begin{reference}Surah al-Inshirah 94:6\\end{reference}
            \\end{quran}

            \\begin{hadith}
            إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ
            \\begin{translation}Actions are judged only by intentions.\\end{translation}
            \\begin{reference}Sahih al-Bukhari 1\\end{reference}
            \\begin{grade}Sahih\\end{grade}
            \\end{hadith}

            \\begin{athar}
            العِلْمُ قَبْلَ القَوْلِ وَالعَمَلِ
            \\begin{translation}Knowledge comes before speech and action.\\end{translation}
            \\begin{reference}Reported from al-Bukhari in his chapter headings\\end{reference}
            \\end{athar}

            \\begin{arabicblock}
            هَذَا نَصٌّ عَرَبِيٌّ تَجْرِيبِيٌّ لِإِظْهَارِ تَنْسِيقِ الكُتْلَةِ العَرَبِيَّةِ العَامَّةِ.
            \\begin{translation}This is a short Arabic sample showing the generic Arabic block treatment.\\end{translation}
            \\end{arabicblock}
            """
        ).strip()

    return textwrap.dedent(
        f"""
        \\documentclass[11pt,fleqn,oneside]{{book}}
        \\usepackage[
          frontpage=star,
          theme=default,
          paper=a5,
          backmatter=false,
          chapternumbering=roman,
          coverstyle=auto,
          runningheader=none,
          toc=false
        ]{{bookish}}

        \\booksetup{{
          title={{Explanation of Laamiyyah}},
          author={{Zayd ibn Hadi Al-Madkhali}},
          imprint={{Salafi Press}},
          publishstatus={{published}}
        }}

        {config}

        \\begin{{document}}
        {body}
        \\end{{document}}
        """
    ).strip() + "\n"


def generate_frontpages() -> None:
    clean_build_dir(FRONTPAGE_BUILD_DIR)
    FRONTPAGE_DIR.mkdir(parents=True, exist_ok=True)
    for style in FRONTPAGE_STYLES:
        tex_path = FRONTPAGE_BUILD_DIR / f"frontpage-{style}.tex"
        write_text(tex_path, frontpage_tex(style))
        pdf_path = compile_tex(tex_path, FRONTPAGE_BUILD_DIR)
        pdf_to_png(pdf_path, FRONTPAGE_DIR / f"{style}.png")
    clean_build_dir(FRONTPAGE_BUILD_DIR)


def generate_prelims() -> None:
    clean_build_dir(PRELIM_BUILD_DIR)
    PRELIM_DIR.mkdir(parents=True, exist_ok=True)
    for style in PRELIM_STYLES:
        tex_path = PRELIM_BUILD_DIR / f"prelim-{style}.tex"
        write_text(tex_path, prelim_tex(style))
        pdf_path = compile_tex(tex_path, PRELIM_BUILD_DIR)
        pdf_to_png(pdf_path, PRELIM_DIR / f"{style}.png")
    clean_build_dir(PRELIM_BUILD_DIR)


def generate_chapters() -> None:
    clean_build_dir(CHAPTER_BUILD_DIR)
    CHAPTER_DIR.mkdir(parents=True, exist_ok=True)
    for style in CHAPTER_STYLES:
        tex_path = CHAPTER_BUILD_DIR / f"chapter-{style}.tex"
        write_text(tex_path, chapter_tex(style))
        pdf_path = compile_tex(tex_path, CHAPTER_BUILD_DIR)
        pdf_to_png(pdf_path, CHAPTER_DIR / f"{style}.png")
    clean_build_dir(CHAPTER_BUILD_DIR)


def generate_special_text() -> None:
    clean_build_dir(SPECIAL_TEXT_BUILD_DIR)
    SPECIAL_TEXT_DIR.mkdir(parents=True, exist_ok=True)
    for style in SPECIAL_TEXT_STYLES:
        tex_path = SPECIAL_TEXT_BUILD_DIR / f"special-text-{style}.tex"
        write_text(tex_path, special_text_tex(style))
        pdf_path = compile_tex(tex_path, SPECIAL_TEXT_BUILD_DIR)
        pdf_to_png(pdf_path, SPECIAL_TEXT_DIR / f"{style}.png")
    clean_build_dir(SPECIAL_TEXT_BUILD_DIR)
