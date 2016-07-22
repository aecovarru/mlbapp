import ReactOnRails from 'react-on-rails';
import HelloWorldApp from './HelloWorldAppClient';
import SeasonTable from '../../Season/startup/SeasonClient';
import GameTable from '../../Games/startup/GameClient';
import BatterTable from '../../Player/startup/BatterClient';
import PitcherTable from '../../Player/startup/PitcherClient';
import WeatherTable from '../../Game/startup/WeatherClient';
import TodoList from '../../TodoList/startup/TodoListClient';
import Game from '../../Games/startup/GameClient';

ReactOnRails.register({ HelloWorldApp });
ReactOnRails.register({ SeasonTable });
ReactOnRails.register({ GameTable });
ReactOnRails.register({ BatterTable });
ReactOnRails.register({ PitcherTable });
ReactOnRails.register({ WeatherTable });
ReactOnRails.register({ TodoList });
ReactOnRails.register({ Game });