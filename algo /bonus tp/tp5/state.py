from __future__ import print_function


class State(object):
    """
    Generic datatype for storing a state.
    A state is defined by:
        - its value (can be anything, for instance a list...)
        - its parent state (i.e the (unique) state whose child is self).
        - its depth (note that this is redundant, since it could be computed
          from parents, but here we explicitly compute it each time a Solution
          is created).
        - its "step" : anything that allows to find a child from a given parent.
    """

    def __init__(self, value, parent, depth=None, step=None):
        self.value = value
        self.parent = parent
        self.depth = depth
        self.step = step
        if depth is None:
            if not parent:
                raise Exception("If you don't specify depth you must specify a\
                                                                        parent")
            else:
                self.depth = self.parent.depth + 1

    def get_path(self):
        if self.parent:
            return self.parent.get_path() + [self.step]
        else:
            return [self.step]

##example:
##state1 = State(value="I'm state 1!", parent=None, depth=0, step="root")
##state2 = State(value="I'm state 2...", parent=state1, step="child1")
##state2bis = State(value="I'm a brother of state 2", parent=state1, step="child2")
##state3 = State(value="I'm the grandson of state 1", parent=state2bis, step="child1")
##print(state3.value)
##print(state3.parent.value)
##print(state3.parent.parent.value)
##print(state3.get_path())
