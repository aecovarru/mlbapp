import ReactOnRails from 'react-on-rails';
import HelloWorldApp from './HelloWorldAppClient';
import SeasonTable from '../../Season/startup/SeasonClient';
import GameTable from '../../Game/startup/GameClient';

ReactOnRails.register({ HelloWorldApp });
ReactOnRails.register({ SeasonTable });
ReactOnRails.register({ GameTable });