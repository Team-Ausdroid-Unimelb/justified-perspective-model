import logging
import util


LOGGER_NAME = "search:heuristic_search"
LOGGER_LEVEL = logging.DEBUG


# logger = logging.getLogger("bfsdc")
# logger.setLevel(logging.DEBUG)

# NOVELTY_KEY_WORD = "@"

class Search:
    def __init__(self,handler):
        self.logger = util.setup_logger(LOGGER_NAME,handler,LOGGER_LEVEL) 
        self.expanded = 0
        self.goal_checked = 0
        self.generated = 0
        self.pruned = 0
        self.visited = []
        self.short_visited = []
        self.result = dict()

    class SearchNode:
        state = None
        epistemic_item_set = set([])
        path = []

        def __init__(self,state,epistemic_item_set,path):
            self.state = state
            self.epistemic_item_set = epistemic_item_set
            self.path = path




    #BFS with duplicate check on the state + epistemic formula
    # for novelty checking purpose, we need to move the goal check process at where the node is generated
    def searching(self,problem, filterActionNames = None):
        
        
        self.logger.info(f'starting searching using heuristic_search')
        self.logger.info(f'the initial is {problem.initial_state}')
        self.logger.info(f'the variables are {problem.variables}')
        self.logger.info(f'the domains are {problem.domains}')
        
        # check whether the initial state is the goal state
        init_state = problem.initial_state
        init_path = [(problem.initial_state,'None')]
        init_epistemic_item_set = set([])
        init_node = Search.SearchNode(init_state,init_epistemic_item_set,init_path)

        
        open_list = util.PriorityQueue()
        open_list.push(item=init_node, priority=_f(init_node,problem))
        
        while not open_list.isEmpty():
            # logger.debug(f"queue length {len(queue)}")
            current_node = open_list.pop()
            state = current_node.state
            epistemic_item_set = current_node.epistemic_item_set
            path = current_node.path
            self.goal_checked += 1
            
            # Goal Check
            is_goal, temp_epistemic_item_set = problem.isGoalN(state,path)
            # print(temp_epistemic_item_set)
            # print(problem.goal_states)
            if is_goal:
                # self.logger.info(path)
                actions = [ a  for s,a in path]
                actions = actions[1:]
                self.logger.info(f'plan is: {actions}')
                self.logger.info(f'Goal found')
                self.result.update({'solvable': True})
                self.result.update({'plan':actions})
                self._finalise_result(problem)
                return self.result
            
            # check whether the node has been visited before
            temp_epistemic_item_set.update(epistemic_item_set)
            temp_epistemic_item_set.update(state)
            # temp_str = state_to_string(temp_epistemic_item_set)
            if not temp_epistemic_item_set in self.visited:
                
                self.expanded +=1
                # print(expanded)
                # update the visited list
                # short_visited.append(temp_str)
                self.visited.append(temp_epistemic_item_set)
                # self.logger.debug(f"visited: {short_visited}")
                # self.logger.debug(f"short visited: {short_visited}")
                # self.logger.debug(f"{temp_epistemic_item_set}")
                # self.logger.debug(f"{state_to_string(temp_epistemic_item_set)}")
                
                # self.logger.debug("finding legal actions:")
                actions = problem.getAllActions(state,path)
                # self.logger.debug(actions)
                filtered_action_names = filterActionNames(problem,actions)
                # self.logger.debug(filtered_action_names)
                for action in filtered_action_names:
                    pre_flag,temp_epistemic_item_set = problem.checkPreconditionsN(state,actions[action],path)
                    if pre_flag: 
                        succ_state = problem.generateSuccessor(state, actions[action],path)
                        succ_node = self.SearchNode(succ_state,temp_epistemic_item_set,path + [(succ_state,action)])
                        self.generated += 1
                        open_list.push(item=succ_node, priority=_f(succ_node,problem))
            else:
                self.pruned += 1
            
            
        self.logger.info(f'Problem is not solvable')
        self.result.update({'plan':[]})
        self.result.update({'solvable': False})
        self._finalise_result(problem)
        return self.result



    def state_to_string(dicts):
        output = ""
        for value in dicts.values():
            output += str(value)
        return output



    def _finalise_result(self,problem):
        # logger output
        self.logger.info(f'[number of node pruned]: {self.pruned}')
        self.logger.info(f'[number of node goal_checked]: {self.goal_checked}')
        self.logger.info(f'[number of node expansion]: {self.expanded}')
        self.logger.info(f'[number of node generated]: {self.generated}')
        self.logger.info(f'[number of epistemic formulas evaluation: {problem.epistemic_calls}]')
        self.logger.info(f'[time in epistemic formulas evaluation: {problem.epistemic_call_time}]')
        # file output
        self.result.update({'pruned':self.pruned})
        self.result.update({'goal_checked':self.goal_checked})
        self.result.update({'expanded':self.expanded})
        self.result.update({'generated':self.generated})
        self.result.update({'epistemic_calls':problem.epistemic_calls})
        self.result.update({'epistemic_call_time':problem.epistemic_call_time.total_seconds()})

def _f(node,problem):
    heuristic = goal_counting
    g = _gn(node)
    h = heuristic(node,problem)
    f = g+h
    return f

def _gn(node):
    path = node.path
    return len(path)-1

# it is not admissible
def goal_counting(node,problem):
    remain_goal_number = 0
    goal_states = problem.goal_states
    ontic_goal_states = goal_states['ontic_g']
    epistemic_goal_states = goal_states['epistemic_g']
    state = node.state
    path = node.path
    
    _, epistemic_item_set = problem.isGoalN(state,path)
    
    for goal,value in ontic_goal_states:
        if goal in state:
            if not state[goal] == value:
                remain_goal_number += 1
        else:
            remain_goal_number += 1    
    
    
    for goal,value in epistemic_goal_states:
        if goal in epistemic_item_set:
            if not epistemic_item_set[goal] == value:
                remain_goal_number += 1
        else:
            remain_goal_number += 1
            
    # print(state)
    # print(epistemic_item_set)
    print(remain_goal_number)
    return remain_goal_number