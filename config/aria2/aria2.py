import subprocess as sp


def ps_runnin(ps):
    """checks if there is a process running containing ps"""
    res = sp.run(["pgrep", "-f", ps], stdout=sp.PIPE, stdin=sp.PIPE)
    print(f"{ps} is running" if not res.returncode else f"{ps} is not running")
    return res.returncode == 0


def addin():
    addd = True
    while addd:
        try:
            cin3 = input("enter the link: ")
            sp.run(["aria2p", "add", cin3], stdout=sp.PIPE, stdin=sp.PIPE)
        except KeyboardInterrupt:
            addd = False


def aria2():
    try:
        c_runnin = ps_runnin("aria2c")
        p_runnin = ps_runnin("aria2p")
        if c_runnin:
            addin()
            sp.run(["aria2p"])
        else:
            sp.run(["aria2c"], stdout=sp.PIPE, stdin=sp.PIPE)
            addin()
            sp.run(["aria2p"])
    except ValueError as ve:
        print(ve)
    except KeyboardInterrupt:
        cin1 = input("do you want to exit? (y/n): ")
        if cin1.lower() == "y":
            if p_runnin:
                print("aria2p also running, it will be exited first")
                sp.run(["pkill", "-f", "aria2p"])
            sp.run(["pkill", "-f", "aria2c"])
            print("aria2c process killed.")


aria2()

"""
TODO:
add the ability to go and edit list files in nvim
ask to add downloads until starting
colored cout
whether to lauch aria2p or not
"""
