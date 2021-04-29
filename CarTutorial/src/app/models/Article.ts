import { BaseModel } from './BaseModel';

export enum LevelEnum {lEasy,lMedium,lHard}
export class Article extends BaseModel {
    Brand : string;
    Category : string;
    Subject : string;
    ToolsNeeded : string;
    Level : LevelEnum;
    MakeModel : string;
    Contents : string;
}