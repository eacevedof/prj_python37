"""
Demonstrates a Rich "application" using the Layout and Live classes.
https://rich.readthedocs.io/en/latest/tables.html?highlight=column#column-options
https://github.com/Textualize/rich/blob/master/examples/fullscreen.py
https://github.com/Textualize/rich/tree/master
"""

from datetime import datetime

from rich import box
from rich.align import Align
from rich.console import Group
from rich.layout import Layout
from rich.panel import Panel
from rich.progress import BarColumn, Progress, SpinnerColumn, TextColumn
from rich.table import Table

from lh_monitor.app_versions.application.services.get_versions_service import get_versions

#console = Console()

#console.print("hello", style="bold red")

vers = get_versions()

def get_dashboard_layout() -> Layout:
    """Define the layout."""
    dash_layout = Layout(name="root")

    dash_layout.split(
        Layout(name="header", size=3),
        Layout(name="body", ratio=1),
        Layout(name="footer", size=7),
    )

    dash_layout["body"].split_row(
        Layout(name="left-column"),
        Layout(name="right-column", ratio=2, minimum_size=60),
    )



    # espacio de la izquierda se divide en dos
    dash_layout["left-column"].split(
        Layout(name="box1"),
        Layout(name="box2")
    )
    return dash_layout


class Header:
    """Display header with clock."""

    def __rich__(self) -> Panel:
        header_table = Table.grid(expand=True)
        header_table.add_column(justify="center", ratio=1)
        header_table.add_column(justify="right")
        header_table.add_row(
            "[b]WinView[/b] monitoring system",
            datetime.now().ctime().replace(":", "[blink]:[/]"),
        )
        return Panel(header_table, style="black on yellow")

def get_panel_sponsor() -> Panel:
    """Some example content."""
    table_sponsor = Table.grid(padding=1)
    table_sponsor.add_column(style="bold red", justify="right")
    table_sponsor.add_column(no_wrap=True)
    table_sponsor.add_row(
        "Twitter",
        "[u blue link=https://twitter.com/textualize]https://twitter.com/textualize",
    )
    table_sponsor.add_row(
        "CEO",
        "[u blue link=https://twitter.com/willmcgugan]https://twitter.com/willmcgugan",
    )
    table_sponsor.add_row(
        "Textualize", "[u blue link=https://www.textualize.io]https://www.textualize.io"
    )

    panel_sponsor = Panel(
        Align.center(
            Group("\n", Align.center(table_sponsor)),
            vertical="middle",
        ),
        box=box.ROUNDED,
        padding=(1, 2),
        title="[b red]Thanks for trying out Rich!",
        border_style="bright_blue",
    )
    return panel_sponsor


job_progress = Progress(
    "{task.description}",
    SpinnerColumn(),
    BarColumn(),
    TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
)
job_progress.add_task("[green]Cooking")
job_progress.add_task("[magenta]Baking", total=200)
job_progress.add_task("[cyan]Mixing", total=400)

overall_progress = Progress()
total_tasks = sum(task.total for task in job_progress.tasks)
overall_task = overall_progress.add_task("All Jobs", total=int(total_tasks))

progress_table = Table.grid(expand=True)
progress_table.add_row(
    Panel(
        overall_progress,
        title="Overall Progress",
        border_style="green",
        padding=(2, 2),
    ),
    Panel(
        job_progress,
        title="[b]Jobs",
        border_style="red",
        padding=(1, 2)
    ),
)


dashboard_layout = get_dashboard_layout()

dashboard_layout["header"].update(Header())
dashboard_layout["right-column"].update(get_panel_sponsor())
#layout["box2"].update(Panel(make_syntax(), border_style="green"))
dashboard_layout["box1"].update(Panel(dashboard_layout.tree, border_style="red"))
dashboard_layout["footer"].update(progress_table)


from time import sleep
from rich.live import Live

with Live(dashboard_layout, refresh_per_second=10, screen=True):
    while not overall_progress.finished:
        sleep(0.1)
        for job in job_progress.tasks:
            if not job.finished:
                job_progress.advance(job.id)

        completed = sum(task.completed for task in job_progress.tasks)
        overall_progress.update(overall_task, completed=completed)